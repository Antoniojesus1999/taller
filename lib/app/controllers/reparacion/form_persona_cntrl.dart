import 'package:diacritic/diacritic.dart';
import 'package:taller/app/data/models/cliente/cliente.dart';

import 'package:taller/app/routes/app_pages.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/services/micro_service.dart';
import 'package:taller/app/services/vehiculo_service.dart';
import 'package:taller/app/utils/snack_bar.dart';

import '../../data/models/vehiculo/vehiculo.dart';
import '../../ui/global_widgets/opciones_lista_cliente.dart';
import '../../utils/string_utiles.dart';

class FormPersonaCntrl extends GetxController {
  final Logger log = Logger();

  //*Se usa en el formulario de persona
  final RoundedLoadingButtonController btnCntlPerson =
      RoundedLoadingButtonController();
  //formulario persona
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

  RxBool microActivo = RxBool(false);
  RxBool isListening = RxBool(false);

  //bool mensajeMostrado = false;

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

  //*Seteamos el cliente que necesita la siguiente pagina para factura
  late Cliente cliente;

  //*Servicios inyectados
  final ClientService clientService;
  final VehiculoService vehiculoService;
  final MicroService microService;

  FormPersonaCntrl({required this.clientService,required this.vehiculoService, required this.microService});

  @override
  Future<void> onInit() async {
    super.onInit();
    await microService.initialize();

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

  //* Setea la primera parte del formulario y nos da la posibilidad de meter al final de este metodo el guardado en baes de datos
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

  Future<void> startListening(String focus, TextEditingController controlador, RxString textoInput, FocusNode focusNode) async {

    isListening.value = true;

    await microService.startListening(
      context: _formContext,
      focus: focus,
      focusNode: focusNode,
      controlador: controlador,
      textoRx: textoInput,
      isListening: isListening,
      obtenerOpciones: (focus == "nif") ?obtenerOpcionesNif :null,
      mostrarSugerencias: (focus == "nif") ?mostrarSugerencias :null,
      ocultarSugerencias: (focus == "nif") ?ocultarSugerencias :null,
    );
  }

  void stopListening() {
    microService.stopListening();
    microActivo.value = false;
    isListening.value = false;
  }

  void onTapInputs(String field, TextEditingController controller, RxString textoRx, FocusNode focus, RxBool tieneFocus) {
    _inicializaTieneFocus();
    tieneFocus.value = true;

    if (microActivo.value) {
      if (controller.text.isNotEmpty) {
        stopListening();
      } else {
        startListening(field, controller, textoRx, focus);
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