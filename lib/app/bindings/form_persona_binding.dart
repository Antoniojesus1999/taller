import 'package:get/get.dart';
import 'package:taller/app/controllers/reparacion/form_persona_cntrl.dart';
import 'package:taller/app/controllers/reparacion/select_vehiculo_cntl.dart';
import 'package:taller/app/services/cliente_service.dart';

import '../repositories/client_repository.dart';
import '../repositories/vehiculo_repository.dart';
import '../services/vehiculo_service.dart';

class FormPersonaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VehiculoRepository());
    Get.lazyPut(() => VehiculoService(vehiculoRepository: Get.find()));

    Get.lazyPut<ClientRepository>(() => ClientRepository());
    Get.lazyPut(() => ClientService(clientRepository: Get.find()));
    Get.lazyPut<FormPersonaCntrl>(() => FormPersonaCntrl(
        clientService: Get.find(), vehiculoService: Get.find()));
    Get.lazyPut<SelectVehiculoCntrl>(() => SelectVehiculoCntrl(
      clientService: Get.find(),vehiculoService: Get.find(), reparacionService: Get.find(),
        ));
  }
}
