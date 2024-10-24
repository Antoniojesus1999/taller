import 'package:taller/app/controllers/home/taller_controller.dart';
import 'package:taller/app/repositories/taller_repository.dart';
import 'package:taller/app/services/taller_service.dart';
import 'package:get/get.dart';

class TallerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TallerRepository>(() => TallerRepository());
    Get.lazyPut(() => TallerService(tallerRepository: Get.find()));
    Get.lazyPut<TallerCntrl>(
        () => TallerCntrl(tallerService: Get.find(), authService: Get.find()));
  }
}
