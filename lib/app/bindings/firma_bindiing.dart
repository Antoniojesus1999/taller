import 'package:get/get.dart';
import 'package:taller/app/controllers/reparacion/firma_cntrl.dart';
import 'package:taller/app/services/cliente_service.dart';

import '../controllers/reparacion/form_danyos_cntrl.dart';
import '../repositories/client_repository.dart';

class FirmaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirmaCntrl>(() => FirmaCntrl(
      clienteService: Get.find(),
    ));
  }
}
