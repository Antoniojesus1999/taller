import 'package:get/get.dart';
import 'package:taller/app/services/cliente_service.dart';

import '../controllers/reparacion/form_danyos_cntrl.dart';
import '../repositories/client_repository.dart';

class ImageWithMarkersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientRepository>(() => ClientRepository());
    Get.lazyPut(() => ClientService(clientRepository: Get.find()));
    Get.lazyPut<ImageMarkerCntrl>(() => ImageMarkerCntrl(
      reparacionService: Get.find(),
    ));
  }
}
