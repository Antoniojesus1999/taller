
import 'package:taller/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../data/models/reparacion/reparacion.dart';
import '../../services/reparacion_service.dart';

class FormDatosAdicionalesCntrl extends GetxController {
  final Logger log = Logger();

  //*Se usa en el formulario de persona
  final RoundedLoadingButtonController btnCntlDatosAdicionales =
      RoundedLoadingButtonController();
  //formulario persona
  final GlobalKey<FormState> formKeyDatosAdecionales = GlobalKey<FormState>();
  final kilometrosCntrl = TextEditingController();

  
  RxString kilometros  = ''.obs;

  //*Servicios inyectados
  final ReparacionService reparacionService;

  FormDatosAdicionalesCntrl({
    required this.reparacionService
  });

  @override
  void onInit() {
    super.onInit();
    Reparacion? reparacion = reparacionService.reparacion;

    if (reparacion.kilometros != null) {
      kilometros.value = reparacion.kilometros!;
    }
  }

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


}
