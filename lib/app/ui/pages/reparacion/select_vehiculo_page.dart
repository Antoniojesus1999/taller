import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/reparacion/select_vehiculo_cntl.dart';

class SelectVehiculoPage extends GetView<SelectVehiculoController> {
  const SelectVehiculoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Datos del vehículo'),
          leading: BackButton(onPressed: Get.back),
        ),
        body: SafeArea(
            minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
            child: Container()));
  }
}
