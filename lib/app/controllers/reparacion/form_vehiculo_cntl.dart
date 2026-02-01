import 'package:taller/app/data/models/coches/color_vehiculo.dart';
import 'package:taller/app/data/models/coches/marca.dart';
import 'package:taller/app/mixins/micro_mixin.dart';

import 'package:taller/app/routes/app_pages.dart';
import 'package:taller/app/services/color_vehiculo_service.dart';
import 'package:taller/app/services/marca_service.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:taller/app/services/reparacion_service.dart';
import 'package:taller/app/services/taller_service.dart';
import 'package:taller/app/services/vehiculo_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/utils/snack_bar.dart';

import '../../data/models/reparacion/reparacion.dart';
import '../../data/models/vehiculo/vehiculo.dart';
import '../micro/micro_cntrl.dart';
import '../../utils/string_utiles.dart';

class FormVehiculoController extends GetxController with MicroMixinRgp {
  RxList<Modelo> modelList = <Modelo>[].obs;
  RxList<String> modelNameList = <String>[].obs;
  RxList<String> listNameBrand = <String>[].obs;
  RxList<ColorVehiculo> listColores = <ColorVehiculo>[].obs;
  Rx<ColorVehiculo> selectedColor = ColorVehiculo().obs;

  RxString selectedCombustible = ''.obs;
  final listCombustible = ['GASOLINA', 'DIESEL', 'HEV', 'PHEV', 'ELECTRICO', 'HIDROGENO'];

  final Logger log = Logger();

  //*Se usa en el formulario de vehiculo
  final GlobalKey<FormState> formKeyVehicle = GlobalKey<FormState>();
  final RoundedLoadingButtonController btnCntlVehicle =
      RoundedLoadingButtonController();

  final matriculaCntrl = TextEditingController();
  final modelCntrl = TextEditingController();
  final brandCntrl = TextEditingController();

  //Usado para el autocomplete para que valla cambiando
  Rx<TextEditingValue> valueBrandEditing = const TextEditingValue().obs;
  Rx<TextEditingValue> valueModelEditing = const TextEditingValue().obs;

  //*Podemos poner final por que el contexto de GetX maneja el estado y siendo final puede cambiar su valor
  RxBool changedListBrand = RxBool(true);
  RxBool changedListColor = RxBool(true);

  late BuildContext _formContext;
  RxString textoMatriculaRx = "".obs;
  RxBool tieneFocusMatricula = RxBool(false);


  final FocusNode matriculaFocus = FocusNode();


  //*Servicios inyectados
  final TallerService tallerService;
  final ClientService clientService;
  final ReparacionService reparacionService;
  final VehiculoService vehiculoService;
  final MarcaService marcaService;
  final ColorVehiculoService colorVehiculoService;
  final MicroCntrl microService;

  FormVehiculoController(
      {required this.tallerService,
      required this.clientService,
      required this.marcaService,
      required this.reparacionService,
      required this.vehiculoService,
      required this.colorVehiculoService,
      required this.microService});

  @override
  void onInit() {
    super.onInit();
    changeBrandAndModel();
    cargarColor();
    onInitCombustible();
    _escucharCambiosEnMicro();
  }

  void onInitCombustible() {
    Vehiculo? vehiculo = vehiculoService.vehiculo;

    if (vehiculo != null && vehiculo.combustible != null) {
      log.i('Combustible seleccionado: ${vehiculo.combustible}');
      // Si el vehiculo ya tiene un combustible asignado, lo seleccionamos
      selectedCombustible.value = vehiculo.combustible!;
    } else {
      selectedCombustible.value = listCombustible.first;
    }
  }

  //* Se ejecuta cuando se envíe el formulario
  void setDataVehicle() async {
    if (!formKeyVehicle.currentState!.validate()) {
      log.i("Formulario de login no correcto");
      btnCntlVehicle.reset();
    } else {
      btnCntlVehicle.success();
      log.i("Formulario de login correcto");

      Vehiculo vehiculo = Vehiculo(
        matricula: matriculaCntrl.text,
        marca: valueBrandEditing.value.text,
        modelo: valueModelEditing.value.text,
        combustible: selectedCombustible.value,
        color: selectedColor.value,
      );
      try {
        await vehiculoService.saveVehiculo(vehiculo);
      } catch (e) {
        openSnackbar(Get.context, 'Error al guardar el vehiculo', Colors.red);
      } finally {
        btnCntlVehicle.reset();
      }

      Reparacion reparacion = Reparacion(
          taller: tallerService.taller,
          cliente: clientService.cliente,
          vehiculo: vehiculoService.vehiculo);

      bool encontrado = false;
      List<Reparacion> reparaciones = reparacionService.reparaciones;
      for (Reparacion rep in reparaciones) {
        if (rep.vehiculo?.matricula == reparacion.vehiculo?.matricula) {
          encontrado = true;
          break;
        }
      }

      if (encontrado) {
        openSnackbar(Get.context,
            'Ya existe una reparación en curso para este vehiculo', Colors.red);
      } else {
        await reparacionService.saveReparacion(reparacion);

        log.i(
            'Cliente seteado en form vehicle ${clientService.cliente.toString()}');
        Get.toNamed(Routes.formDatosAdicionales);
        btnCntlVehicle.reset();
      }
    }
  }

  //* Precargamos los datos que ha seleccionado el usuario
  void setDataVehiculoInPage() {
    matriculaCntrl.text = vehiculoService.vehiculo.matricula!;
    valueBrandEditing.value =
        TextEditingValue(text: vehiculoService.vehiculo.marca!);
    valueModelEditing.value =
        TextEditingValue(text: vehiculoService.vehiculo.modelo!);
    selectedColor.value = vehiculoService.vehiculo.color!;
  }

  //* Se inicia en el onInit y hace una petición para obtener las marcas y los modelos
  Future<void> changeBrandAndModel() async {
    try {
      log.i('Haciendo petición desde el controller para recuperar las marcas');
      await marcaService.getBrand().then((_) {
        log.i('Cargando nombre marcas');
        modelList.value = marcaService.listModel;

        //Get brand hace petición y carga en las listas en el service y nosotros la copiamos en el controller para manipularla
        modelNameList.value = marcaService.listNameModel;

        listNameBrand.value = marcaService.listNameBrand;
      });
    } catch (e) {
      log.f('Error al cargar las marcas');
      throw Exception('Error al cargar las marcas');
    } finally {
      changedListBrand.value = false;
    }
  }

  Future<void> cargarColor() async {
    try {
      log.i('Haciendo petición desde el controller para cargar los colores');
      await colorVehiculoService.getColores().then((_) {
        log.i('Cargando colores');
        listColores.value = colorVehiculoService.listColores;
      });
    } catch (e) {
      log.f('Error al cargar los colores');
      throw Exception('Error al cargar los colores');
    } finally {
      if (vehiculoService.vehiculo.id != null) {
        selectedColor.value = listColores.firstWhere(
            (color) => color.nombre == vehiculoService.vehiculo.color.nombre);
      } else {
        selectedColor.value = listColores.first;
      }
      changedListColor.value = false;
    }
  }

  //*Se usa para en el autocomplete cuando hace clic en una opción
  void handleBrandSelection(String nameBrand) {
    log.i('Se ha marcado la marca ${nameBrand.toString()}');

    List<Modelo> modelos = marcaService.listBrand
        .firstWhere((brand) => brand.nombre == nameBrand)
        .modelos;

    ///Metemos en el modelo el valor
    ///modelCntrl.value.text = modelName;
    valueModelEditing.value = TextEditingValue(text: modelos[0].nombre);
    log.i('valor initValueModel.value ${valueModelEditing.value.toString()}');

    modelNameList.value = modelos.map((model) => model.nombre).toList();

    valueBrandEditing.value = TextEditingValue(text: nameBrand);
  }

  void handleModelSelection(String nombreModelo) {
    log.i('Se ha marcado la marca $nombreModelo');
    String nombreMarca = marcaService.findMarcaByNombreModelo(nombreModelo);

    valueBrandEditing.value = TextEditingValue(text: nombreMarca);

    valueModelEditing.value = TextEditingValue(text: nombreModelo);
  }

  void handleColorSelection(ColorVehiculo colorVehiculo) {
    log.i('Se ha marcado el color $colorVehiculo');
    selectedColor.value = colorVehiculo;
  }

  void handleArguments(Map<String, dynamic>? args) {
    if (args != null && args.containsKey('from')) {
      if (args['from'] == 'fromSelectVehicle') {
        setDataVehiculoInPage();
      } else if (args['from'] == 'fromPerson') {
        List<Vehiculo> listaVehiculo = args['listaVehiculo'];
        if (listaVehiculo.isNotEmpty) {
          vehiculoService.setVehiculo = listaVehiculo.first;
          setDataVehiculoInPage();
        }
      }
    }
  }

  void handleCombustibleSelection(String combustible) {
    selectedCombustible.value = combustible;
  }

  Iterable<String> obtenerOpcionesMarca(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return listNameBrand.where((String option) {
      final text = textEditingValue.text.toLowerCase();
      final optionLower = option.toLowerCase();
      return optionLower.startsWith(text);
    });
  }

  Iterable<String> obtenerOpcionesModelo(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return modelNameList.where((String option) {
      final text = textEditingValue.text.toLowerCase();
      final optionLower = option.toLowerCase();
      return optionLower.startsWith(text);
    });
  }

  void _escucharCambiosEnMicro() {
    ever(microActivo, (bool escuchando) {
      if (escuchando) {
        Get.snackbar(
          'Micrófono activo',
          'Seleccciona un campo y dicta el texto por voz',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.indigo,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 2500),
        );
      }
    });
  }

   void clearInput(TextEditingController controller, RxString stringRx, FocusNode focusNode) {
    controller.clear();
    stringRx.value = '';
    focusNode.unfocus();
  }

  void limpiarFormulario() {
    clearInput(matriculaCntrl,textoMatriculaRx , matriculaFocus);
    matriculaCntrl.clear();
/*    modelCntrl.clear();
    brandCntrl.clear();*/

  }

  void onChangeRestInputs(String texto, TextEditingController controller, RxString textoRx) {
    final textoCap = capitalizeFirstLetter(texto);
    controller.text = textoCap;
    textoRx.value = textoCap;
  }

  void onTapInputs(String input, TextEditingController controlador, RxString textoRx, FocusNode focus, RxBool tieneFocus) {
    _inicializaTieneFocus();
    tieneFocus.value = true;

    if (microActivo.value) {
      if (controlador.text.isNotEmpty) {
        stopMicro();
      } else {
        startListening(
          input: input,
          focusNode: focus,
          controlador: controlador,
          textoRx: textoRx,
          context: _formContext,
        );
      }
    }
  }

  void _inicializaTieneFocus() {
    tieneFocusMatricula.value = false;
  }

  void setFormContext(BuildContext context) {
    _formContext = context;
  }
}
