import 'package:get/get.dart';
import 'package:taller/app/controllers/pdf/pdf_controller.dart';
import 'package:taller/app/repositories/pdf/pdf_repository.dart';


class PdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PdfRepository());
    Get.lazyPut<PdfController>(() => PdfController(pdfRepository: Get.find()));
  }
}
