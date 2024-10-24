import 'package:get/get.dart';

import '../controllers/auth/mail_verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MailVerificationController());
  }
}
