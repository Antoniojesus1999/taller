import 'package:get/get.dart';
import 'package:taller/app/repositories/client_repository.dart';
import 'package:taller/app/repositories/reparacion_repository.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:taller/app/services/reparacion_service.dart';

import '../controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<ClientRepository>(() => ClientRepository());
    Get.lazyPut<ClientService>(
        () => ClientService(clientRepository: Get.find()));
    Get.lazyPut<ReparacionRepository>(() => ReparacionRepository());
    Get.lazyPut<ReparacionService>(
        () => ReparacionService(reparacionRepository: Get.find()));
    Get.lazyPut<HomeController>(
        () => HomeController(workService: Get.find(), authService: Get.find(),
            tallerService: Get.find()));
  }
}
