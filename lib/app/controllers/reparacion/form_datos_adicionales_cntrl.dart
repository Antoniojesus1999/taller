
import 'package:taller/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../data/models/reparacion/reparacion.dart';
import '../micro/micro_cntrl.dart';
import '../../services/reparacion_service.dart';

class FormDatosAdicionalesCntrl extends GetxController {
  final Logger log = Logger();

  //*Se usa en el formulario de persona
  final RoundedLoadingButtonController btnCntlDatosAdicionales =
      RoundedLoadingButtonController();
  //formulario persona
  final GlobalKey<FormState> formKeyDatosAdecionales = GlobalKey<FormState>();
  final kilometrosCntrl = TextEditingController();

  late BuildContext _formContext;

  final FocusNode kmsFocus = FocusNode();

/*  RxBool tieneFocuskms = RxBool(false);
  RxString textoKmsRx  = ''.obs;
  RxBool tieneFocusKms = RxBool(false);

  RxBool microActivo = RxBool(false);
  RxBool isListening = RxBool(false);*/
  
  //*Servicios inyectados
  final ReparacionService reparacionService;

  FormDatosAdicionalesCntrl({
    required this.reparacionService
  });

  @override
  void onInit() {
    super.onInit();
    Reparacion? reparacion = reparacionService.reparacion;

    //_escucharCambiosEnMicro();

/*    if (reparacion.kilometros != null) {
      textoKmsRx.value = reparacion.kilometros!;
    }*/
  }

  void setFormContext(BuildContext context) {
    _formContext = context;
  }

/*  void _escucharCambiosEnMicro() {
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
  }*/

  //* Setea la primera parte del formulario y nos da la posibilidad de meter al final de este metodo el guardado en baes de datos
  void setDatosAdicionales() async {
    if (!formKeyDatosAdecionales.currentState!.validate()) {
      log.i("Formulario Datos Adicionales no correcto");
      btnCntlDatosAdicionales.reset();
    } else {
      btnCntlDatosAdicionales.success();
      log.i("Formulario Datos Adicionales correcto");

      Reparacion reparacion  = reparacionService.reparacion;
      reparacion.kilometros = kilometrosCntrl.text;
      
      try {
        await reparacionService.saveReparacion(reparacion);
      } catch (e) {
        handleSaveReparacionError(e as Exception);
        return; // Detener la ejecución del método
      }

      
      log.i('Reparación seteada en form person ${reparacionService.reparacion}');

      Get.toNamed(Routes.imageWithMarkers);
      btnCntlDatosAdicionales.reset();
    }
  }

  void handleSaveReparacionError(Exception e) {
    btnCntlDatosAdicionales.reset();
/*    openSnackbar(
        Get.context,
        'Para pasar a la siguiente pagina tienes que introducir un dni o email valido',
        Colors.red);*/
    Get.toNamed(Routes.formDatosAdicionales);
  }

/*  Future<void> startListening(String focus, TextEditingController controlador, RxString textoInput, FocusNode focusNode) async {

    isListening.value = true;

    await microService.startListening(
      context: _formContext,
      focus: focus,
      focusNode: focusNode,
      controlador: controlador,
      textoRx: textoInput,
      isListening: isListening,
      obtenerOpciones: null,
      mostrarSugerencias: null,
      ocultarSugerencias: null,
    );
  }

  void stopListening() {
    microService.stopListening();
    microActivo.value = false;
    isListening.value = false;
  }*/

  void onTapInputs(String field, TextEditingController controller, RxString textoRx, FocusNode focus, RxBool tieneFocus) {
    //_inicializaTieneFocus();
    tieneFocus.value = true;

/*    if (microActivo.value) {
      if (controller.text.isNotEmpty) {
        stopListening();
      } else {
        startListening(field, controller, textoRx, focus);
      }
    }*/
  }

/*  void _inicializaTieneFocus() {
    tieneFocusKms.value = false;
  }*/

  void clearInput(TextEditingController controller, RxString stringRx, FocusNode focusNode) {
    controller.clear();
    stringRx.value = '';
    focusNode.unfocus();
  }

}
