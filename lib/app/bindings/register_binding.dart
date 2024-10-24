import 'package:get/get.dart';
import 'package:taller/app/controllers/auth/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(authService: Get.find()));
  }
}
