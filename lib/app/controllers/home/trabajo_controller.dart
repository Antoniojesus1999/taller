import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/data/models/reparacion/reparacion.dart';
import 'package:taller/app/services/reparacion_service.dart';

class TrabajoController extends GetxController {
  final GlobalKey<FormState> formTrabajo = GlobalKey<FormState>();
  final descripcionTrabajo = TextEditingController();
  final btnCntlFormTrabajo = RoundedLoadingButtonController();
  final btnCntlGenerarPdf = RoundedLoadingButtonController();

  late String idReparacion;
  RxList<String> trabajos = <String>[].obs;

  final ReparacionService reparacionService;

  TrabajoController({required this.reparacionService});

  void sendData() async {
    if (formTrabajo.currentState!.validate()) {
      btnCntlFormTrabajo.success();
      await reparacionService.saveTrabajo(
          idReparacion, descripcionTrabajo.text);
      await getTrabajosByReparacion(idReparacion);
      descripcionTrabajo.clear();
    }

    btnCntlFormTrabajo.reset();
  }

  void handleArguments(Map<String, dynamic>? args) async{
    if (args != null) {
      if (args['idReparacion'] != null) {
        idReparacion = args['idReparacion'];
        await getTrabajosByReparacion(idReparacion);
      } else {
        Get.snackbar('Error', 'No se ha podido cargar la reparación');
      }
    } else {
      Get.snackbar('Error', 'No se ha podido cargar los argumentos');
    }
  }

  Future<void> getTrabajosByReparacion(String idReparacion) async {
    List<Trabajo> a = await reparacionService.getTrabajos(idReparacion);
    trabajos.assignAll(a.map((e) => e.descripcion).toList());
  }
}
