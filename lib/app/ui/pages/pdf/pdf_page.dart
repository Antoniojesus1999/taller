
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:taller/app/controllers/pdf/pdf_controller.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';

class PdfPage extends GetView<PdfController> {
  const PdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar PDF'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.pdfBytes.value != null) {
                return PDFView(
                  pdfData: controller.pdfBytes.value!,
                );
              } else {
                return const Center(
                  child: Text('No se ha generado ningún PDF.'),
                );
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BtnLoad(
                  btnController: controller.btnCntrlDescargarPdf,
                  onTap: () => controller.downloadPdf(),
                  title: '',
                  width: 100,
                  icon: const Icon(Icons.download, color: Colors.white, size: 30,)
                ),
                BtnLoad(
                  btnController: controller.btnCntrlFirmarPdf,
                  onTap: () => controller.firmarPdf(),
                  title: '',
                  width: 100,
                  icon: const Icon(Icons.draw_outlined, color: Colors.white, size: 30,),
                ),
                BtnLoad(
                  btnController: controller.btnCntrlEnviarPdf,
                  onTap: () => controller.sharePdf(),
                  title: '',
                  width: 100,
                  icon: const Icon(Icons.share_outlined, color: Colors.white, size: 30,)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  
  
  
  
}
