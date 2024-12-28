import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taller/app/routes/app_pages.dart';

import '../../../controllers/reparacion/select_vehiculo_cntl.dart';

class SelectVehiculoPage extends GetView<SelectVehiculoCntrl> {
  const SelectVehiculoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    controller.handleArguments(args);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del vehículo'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
        child: ListView.builder(
          itemCount: controller.listVehiculo.length,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.only(top: 10.0),
                elevation: 10.0,
                child: ListTile(
                    tileColor: const Color.fromRGBO(250, 250, 250, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    leading: const Icon(
                      Icons.handyman,
                      size: 25,
                      color: Color.fromRGBO(2, 136, 209, 1.0),
                    ),
                    //titleAlignment: ListTileTitleAlignment.threeLine,
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(controller.listVehiculo[index].marca!),
                          SizedBox(width: 5),
                          Text(controller.listVehiculo[index].modelo!),
                          SizedBox(width: 5),
                          Text(controller.listVehiculo[index].matricula!),
                        ],
                      ),
                    ),
                    subtitle: Text('${controller.listVehiculo[index].updatedAt}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          headerAnimationLoop: false,
                          animType: AnimType.topSlide,
                          title: 'Confirmación',
                          desc:
                              '¿Estás seguro de que deseas eliminar este vehículo?',
                          btnCancelOnPress: () {
                            Get.back();
                          },
                          btnOkOnPress: () {
                            controller.eliminarVehiculo(controller.listVehiculo[index]);
                            Get.snackbar(
                                'Éxito', 'El vehiculo ha sido eliminado');
                          },
                        ).show();
                      },
                    ),
                    onTap: () {
                      controller.setVehiculo(controller.listVehiculo[index]);
                      Get.toNamed(Routes.formVehicle,
                          arguments: {'from': 'fromSelectVehicle'});
                    }));
          },
        ),
      ),
    );
  }
}
