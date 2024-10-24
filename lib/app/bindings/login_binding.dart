import 'package:get/get.dart';
import 'package:taller/app/services/taller_service.dart';

import '../controllers/auth/login_controller.dart';
import '../data/provider/internet_provider.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(authService: Get.find()));
    Get.lazyPut(() => InternetProvider());
    Get.lazyPut( () => TallerService(tallerRepository: Get.find()));

  }
}
