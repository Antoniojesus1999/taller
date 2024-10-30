import 'package:get/get.dart';
import 'package:taller/app/controllers/reparacion/form_vehiculo_cntl.dart';
import 'package:taller/app/repositories/marcas_repository.dart';
import 'package:taller/app/repositories/vehiculo_repository.dart';
import 'package:taller/app/services/vehiculo_service.dart';

import '../services/marca_service.dart';

class FormVehiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MarcasRepository());
    Get.lazyPut(() => VehiculoRepository());
    Get.lazyPut(() => MarcaService(marcasRepository: Get.find()));
    Get.lazyPut(() => VehiculoService(vehiculoRepository: Get.find()));
    Get.lazyPut<FormVehiculoController>(() => FormVehiculoController(
        clientService: Get.find(),
        marcaService: Get.find(),
        reparacionService: Get.find(),
        vehiculoService: Get.find()));
  }
}
