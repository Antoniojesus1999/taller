import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taller/app/data/models/vehiculo/vehiculo.dart';
import 'package:taller/app/routes/app_pages.dart';

import '../../../controllers/reparacion/select_vehiculo_cntl.dart';

class SelectVehiculoPage extends GetView<SelectVehiculoCntrl> {
  const SelectVehiculoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Vehiculo> vehiculos = Get.arguments as List<Vehiculo>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del vehículo'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
        child: ListView.builder(
          itemCount: vehiculos.length,
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
                    title: Row(
                      children: [
                        Text(vehiculos[index].marca!),
                        SizedBox(width: 5),
                        Text(vehiculos[index].modelo!),
                        SizedBox(width: 5),
                        Text(vehiculos[index].matricula!),
                      ],
                    ),
                    subtitle: Text('${vehiculos[index].updatedAt}'),
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
                            controller.eliminarVehiculo(vehiculos[index]);
                            Get.snackbar(
                                'Éxito', 'El vehiculo ha sido eliminado');
                          },
                        ).show();
                      },
                    ),
                    onTap: () {
                      controller.setVehiculo(vehiculos[index]);
                      Get.toNamed(Routes.imageWithMarkers);
                    }));
          },
        ),
      ),
    );
  }
}
