import 'package:taller/app/controllers/invoice/reparacion_detail_controller.dart';
import 'package:get/get.dart';

class ReparacionDetailBinding extends Bindings {
  @override
  void dependencies() {
    /*Get.lazyPut<ClientRepository>(() => ClientRepository());
    Get.lazyPut<ClientService>(
        () => ClientService(clientRepository: Get.find()));*/
    Get.lazyPut<ReparacionDetailController>(() => ReparacionDetailController());
  }
}
