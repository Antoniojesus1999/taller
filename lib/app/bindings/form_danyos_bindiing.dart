import 'package:get/get.dart';
import 'package:taller/app/services/cliente_service.dart';

import '../controllers/reparacion/form_danyos_cntrl.dart';

class ImageWithMarkersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormDanyosCntrl>(() => FormDanyosCntrl(
        reparacionService: Get.find()));
  }
}
