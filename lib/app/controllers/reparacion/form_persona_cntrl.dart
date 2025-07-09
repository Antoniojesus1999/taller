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

  final FocusNode nameFocus = FocusNode();
  final FocusNode surName1Focus = FocusNode();
  final FocusNode surName2Focus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode tlfFocus = FocusNode();

//  late stt.SpeechToText speech;
  RxBool microActivo = RxBool(false);
  RxBool isListening = RxBool(false);
//  late String? localeId;
  RxString textoRx = "".obs;

  late final LayerLink nifFieldLink = LayerLink();
  OverlayEntry? overlaySugerenciasPorVoz;

  RxBool nifSeleccionado = RxBool(false);

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
    nifCntrl.addListener(() {
      textoRx.value = nifCntrl.text;
      if (nifCntrl.text.isEmpty) {
        nifSeleccionado.value = false;
        nameCntrl.clear();
        surName1Cntrl.clear();
        surName2Cntrl.clear();
        emailCntrl.clear();
        tlfCntrl.clear();
      }
    });
    clientService.getAllClientsByTaller();
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

  Iterable<String> obtenerOpcionesNif(TextEditingValue textEditingValue) {
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

    final coincidencias = clientService.clientes
        .where((cliente) => cliente.nif?.startsWith(texto) ?? false)
        .map((cliente) => cliente.nif!)
        .toList();

    if (coincidencias.isEmpty) {
      nifCntrl.text = texto;
    }

    return coincidencias;
  }

  Future<void> startListening(BuildContext context) async {
    microActivo.value = true;
    isListening.value = true;

    final focus = controladorDelCampoConFocus;
    final TextEditingController controlador;

    if (focus == "name") {
      controlador = nameCntrl;
    } else  {
      controlador = nifCntrl;
    }

    await microService.startListening(
      context: context,
      focus: focus,
      controlador: controlador,
      textoRx: textoRx,
      obtenerOpcionesNif: obtenerOpcionesNif,
      mostrarSugerenciasPorVoz: mostrarSugerenciasPorVoz,
      ocultarSugerenciasPorVoz: ocultarSugerenciasPorVoz,
    );

    isListening.value = false;
  }

  void stopListening() {
    microService.stopListening();
    microActivo.value = false;
    isListening.value = false;
  }

  String get controladorDelCampoConFocus {
    if (nameFocus.hasFocus) return "name";
    if (surName1Focus.hasFocus) return "surName1";
    if (surName2Focus.hasFocus) return "surName2";
    if (emailFocus.hasFocus) return "email";
    if (tlfFocus.hasFocus) return "tlf";
    return "nif"; // Ningún campo tiene focus
  }

  void mostrarSugerenciasPorVoz(BuildContext context, List<String> sugerencias) {
    ocultarSugerenciasPorVoz(); // Cierra si ya hay uno

    overlaySugerenciasPorVoz = OverlayEntry(
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

                nifCntrl.text = cliente.nif ?? '';
                nameCntrl.text = cliente.nombre ?? '';
                surName1Cntrl.text = cliente.apellido1 ?? '';
                surName2Cntrl.text = cliente.apellido2 ?? '';
                tlfCntrl.text = cliente.telefono ?? '';
                emailCntrl.text = cliente.email ?? '';

                ocultarSugerenciasPorVoz();
              },
            ),
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(overlaySugerenciasPorVoz!);
  }

  void ocultarSugerenciasPorVoz() {
    overlaySugerenciasPorVoz?.remove();
    overlaySugerenciasPorVoz = null;
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


}