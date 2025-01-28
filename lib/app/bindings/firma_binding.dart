import 'package:get/get.dart';
import 'package:taller/app/controllers/reparacion/firma_cntrl.dart';


class FirmaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirmaCntrl>(() => FirmaCntrl(
      clienteService: Get.find(),
    ));
  }
}
