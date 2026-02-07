import 'package:diacritic/diacritic.dart';
import 'package:taller/app/data/models/cliente/cliente.dart';

import 'package:taller/app/routes/app_pages.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/controllers/micro/micro_cntrl.dart';
import 'package:taller/app/services/vehiculo_service.dart';
import 'package:taller/app/utils/snack_bar.dart';

import '../../data/models/vehiculo/vehiculo.dart';
import '../../mixins/micro_mixin.dart';
import '../../ui/global_widgets/opciones_lista_cliente.dart';
import '../../utils/string_utiles.dart';

class FormPersonaCntrl extends GetxController with MicroMixinRgp {
  final Logger log = Logger();

  final RoundedLoadingButtonController btnCntlPerson = RoundedLoadingButtonController();

  final GlobalKey<FormState> formKeyPerson = GlobalKey<FormState>();
  final nifCntrl = TextEditingController();
  final nameCntrl = TextEditingController();
  final surName1Cntrl = TextEditingController();
  final surName2Cntrl = TextEditingController();
  final tlfCntrl = TextEditingController();
  final emailCntrl = TextEditingController();

  final FocusNode nifFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode surName1Focus = FocusNode();
  final FocusNode surName2Focus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode tlfFocus = FocusNode();

  RxBool tieneFocusNif = RxBool(false);
  RxBool tieneFocusName = RxBool(false);
  RxBool tieneFocusSurname1 = RxBool(false);
  RxBool tieneFocusSurname2 = RxBool(false);
  RxBool tieneFocusEmail = RxBool(false);
  RxBool tieneFocusTlf = RxBool(false);

  RxString textoNifRx = "".obs;
  RxString textoNameRx = "".obs;
  RxString textoSurName1Rx = "".obs;
  RxString textoSurName2Rx = "".obs;
  RxString textoEmailRx = "".obs;
  RxString textoTlfRx = "".obs;

  late final LayerLink nifFieldLink = LayerLink();
  OverlayEntry? overlaySugerencias;

  RxBool nifSeleccionado = RxBool(false);

  late BuildContext _formContext;

  late Cliente cliente;

  final ClientService clientService;
  final VehiculoService vehiculoService;

  FormPersonaCntrl({required this.clientService,required this.vehiculoService});

  @override
  Future<void> onInit() async {
    super.onInit();
    await initializeMicro();

    clientService.getAllClientsByTaller();

    _escucharCambiosEnMicro();

  }

  void setFormContext(BuildContext context) {
    _formContext = context;
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

  void setDataPersona() async {
    if (!formKeyPerson.currentState!.validate()) {
      log.i("Formulario de login no correcto");
      btnCntlPerson.reset();
    } else {
      btnCntlPerson.success();
      log.i("Formulario de login correcto");
      if (nifSeleccionado == RxBool(false)) {
        cliente = Cliente(nif: nifCntrl.text, nombre: nameCntrl.text);
      } else {
        cliente.nif = nifCntrl.text;
        cliente.nombre = nameCntrl.text;
      }
      cliente.apellido1 = surName1Cntrl.text;
      cliente.apellido2 = surName2Cntrl.text;
      cliente.telefono = tlfCntrl.text;
      cliente.email = emailCntrl.text;

      try {
        await clientService.saveCliente(cliente);
      } catch (e) {
        handleSaveClientError(e as Exception);
        return; // Detener la ejecución del método
      }

      
      log.i('Cliente seteado en form person ${clientService.cliente}');
      //Metodo que decisor para mostrar una la pantalla formVehicle o selectVehicle

      await handleViewFormVehicleOrSelectVehicle(clientService.cliente.id!);
      btnCntlPerson.reset();
    }
  }

  void handleSaveClientError(Exception e) {
    btnCntlPerson.reset();
    log.e('${e.toString()} el cliente tiene que tener un dni valido');
    openSnackbar(
        Get.context,
        'Para pasar a la siguiente pagina tienes que introducir un dni o email valido',
        Colors.red);
    Get.toNamed(Routes.formPerson);
  }
  
  /// Metodo decisor para saber si ir a la pantalla formVehicle o a la pantalla selectVehicle
  Future handleViewFormVehicleOrSelectVehicle(String idCliente) async{
    List<Vehiculo> listaVehiculo = await vehiculoService.getAllVehiculosByCliente(idCliente);
    if (listaVehiculo.isEmpty || listaVehiculo.length == 1) {
      await Get.toNamed(Routes.formVehicle, arguments:  {'from': 'fromPerson','listaVehiculo': listaVehiculo});
    } else {
      await Get.toNamed(Routes.selectVehicle, arguments: {'listaVehiculo': listaVehiculo});
    }
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
          obtenerOpciones: (input == "nif") ?obtenerOpcionesNif :null,
          mostrarSugerencias: (input == "nif") ?mostrarSugerencias :null,
          ocultarSugerencias: (input == "nif") ?ocultarSugerencias :null,
        );
      }
    }
  }

  void _inicializaTieneFocus() {
    tieneFocusNif.value = false;
    tieneFocusName.value = false;
    tieneFocusSurname1.value =false;
    tieneFocusSurname2.value = false;
    tieneFocusEmail.value = false;
    tieneFocusTlf.value = false;
  }

  Iterable<String> obtenerOpcionesNif(TextEditingValue textEditingValue, bool contieneNumeros) {
    final texto = textEditingValue.text;

    if (texto.isEmpty) {
      nifSeleccionado.value = false;
      nifCntrl.text = "";
      nameCntrl.clear();
      surName1Cntrl.clear();
      surName2Cntrl.clear();
      emailCntrl.clear();
      tlfCntrl.clear();
      return const Iterable<String>.empty();
    }

    Iterable<String> coincidencias;

    if (contieneNumeros) {
      coincidencias = clientService.clientes
          .where((cliente) => cliente.nif?.startsWith(texto) ?? false)
          .map((cliente) => '${cliente.nif} - ${cliente.nombre} ${cliente.apellido1 ?? ''} ${cliente.apellido2 ?? ''}')
          .toList();
    } else {
      final normalizado = removeDiacritics(texto.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim());

      coincidencias = clientService.clientes.where((cliente) {
        final nombre = removeDiacritics((cliente.nombre ?? '').toLowerCase().trim());
        final apellido1 = removeDiacritics((cliente.apellido1 ?? '').toLowerCase().trim());
        final apellido2 = removeDiacritics((cliente.apellido2 ?? '').toLowerCase().trim());

        final completo1 = "$nombre $apellido1";
        final completo2 = "$nombre $apellido1 $apellido2";

        return completo1 == normalizado || completo2 == normalizado;
      }).map((cliente) =>
      '${cliente.nif} - ${cliente.nombre} ${cliente.apellido1 ?? ''} ${cliente.apellido2 ?? ''}'
      ).toList();
    }

    if (coincidencias.isEmpty && contieneNumeros) {
      nifCntrl.text = texto;
    }

    return coincidencias;
  }

  void mostrarSugerencias(BuildContext context, List<String> sugerencias) {
    ocultarSugerencias(); // Cierra si ya hay uno

    overlaySugerencias = OverlayEntry(
      builder: (context) {
        return Positioned(
          child: CompositedTransformFollower(
            link: nifFieldLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 56), // Ajusta si la altura del input es distinta
            child: OpcionesListaCliente(
              opciones: sugerencias,
              onSelected: (opcion) {
                final cliente = clientService.clientes.firstWhere((c) => c.nif == opcion);
                nifSeleccionado.value = true;
                this.cliente = cliente;

                textoNifRx.value = cliente.nif ?? '';
                nifCntrl.text = cliente.nif ?? '';
                nameCntrl.text = cliente.nombre ?? '';
                surName1Cntrl.text = cliente.apellido1 ?? '';
                surName2Cntrl.text = cliente.apellido2 ?? '';
                tlfCntrl.text = cliente.telefono ?? '';
                emailCntrl.text = cliente.email ?? '';

                ocultarSugerencias();
              },
            ),
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(overlaySugerencias!);
  }

  void ocultarSugerencias() {
    overlaySugerencias?.remove();
    overlaySugerencias = null;
  }

  void onClienteSeleccionado(String nifCliente) {
    final cliente = clientService.clientes
        .singleWhere((cliente) => cliente.nif == nifCliente);

    nifSeleccionado = RxBool(true);
    this.cliente = cliente;

    nifCntrl.text = cliente.nif ?? '';
    nameCntrl.text = cliente.nombre ?? '';
    surName1Cntrl.text = cliente.apellido1 ?? '';
    surName2Cntrl.text = cliente.apellido2 ?? '';
    tlfCntrl.text = cliente.telefono ?? '';
    emailCntrl.text = cliente.email ?? '';
  }

  void clearInput(TextEditingController controller, RxString stringRx, FocusNode focusNode) {
    controller.clear();
    stringRx.value = '';
    focusNode.unfocus();
  }

  void limpiarFormulario() {
    clearInput(nifCntrl, textoNifRx, nifFocus);
    nameCntrl.clear();
    surName1Cntrl.clear();
    surName2Cntrl.clear();
    emailCntrl.clear();
    tlfCntrl.clear();
    nifSeleccionado.value = false;
  }

  void onChangeRestInputs(String texto, TextEditingController controller, RxString textoRx) {
    final textoCap = capitalizeFirstLetter(texto);
    controller.text = textoCap;
    textoRx.value = textoCap;
  }

}