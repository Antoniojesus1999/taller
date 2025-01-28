import 'package:get/get.dart';
import '../controllers/reparacion/form_danyos_cntrl.dart';

class ImageWithMarkersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormDanyosCntrl>(() => FormDanyosCntrl(
        reparacionService: Get.find()));
  }
}
