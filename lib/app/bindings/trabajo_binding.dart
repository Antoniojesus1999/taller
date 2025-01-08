import 'package:get/get.dart';
import 'package:taller/app/controllers/home/trabajo_controller.dart';


class TrabajoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrabajoController>(() => TrabajoController(reparacionService: Get.find()));
  }
}
