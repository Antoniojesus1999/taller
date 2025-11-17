import 'package:get/get.dart';
import 'package:taller/app/controllers/reparacion/form_vehiculo_cntl.dart';
import 'package:taller/app/repositories/marcas_repository.dart';
import 'package:taller/app/services/color_vehiculo_service.dart';

import '../repositories/color_vehiculo_repository.dart';
import '../services/marca_service.dart';

class FormVehiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MarcasRepository());
    Get.lazyPut(() => MarcaService(marcasRepository: Get.find()));
    Get.lazyPut(() => ColorVehiculoRepository());
    Get.lazyPut(() => ColorVehiculoService(colorVehiculoRepository: Get.find()));
    Get.lazyPut<FormVehiculoController>(() => FormVehiculoController(
        tallerService: Get.find(),
        clientService: Get.find(),
        marcaService: Get.find(),
        reparacionService: Get.find(),
        vehiculoService: Get.find(),
        colorVehiculoService: Get.find(),
        microService: Get.find()));

  }
}
