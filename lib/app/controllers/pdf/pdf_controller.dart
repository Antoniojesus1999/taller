import 'dart:typed_data';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import 'package:taller/app/repositories/pdf/pdf_repository.dart';
import 'package:taller/app/services/reparacion_service.dart';

class PdfController extends GetxController {
  final PdfRepository pdfRepository;
  RxString errorMessage = ''.obs;
  final pdfBytes = Rxn<Uint8List>();
  RxBool isLoading = false.obs;
  final btnCntrlDescargarPdf = RoundedLoadingButtonController();
  final btnCntrlEnviarPdf = RoundedLoadingButtonController();
  final reparacionService = Get.find<ReparacionService>();

  PdfController({required this.pdfRepository});

  @override
  onInit() {
    super.onInit();
    loadPdf();
  }

  Future<void> loadPdf() async {
    try {
      isLoading(true);
      pdfBytes.value = await pdfRepository.fetchPdfBytes(reparacionService.reparacion.id!);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadOrViewPdf(String value) async {
    if (value == 'download') {
      // Verificar y solicitar permisos de almacenamiento
      try {
        if (await Permission.manageExternalStorage.request().isGranted) {
          // Permiso concedido, preguntar dónde guardar el archivo
          final dir = await getTemporaryDirectory();

          String filename = '${dir.path}/prueba.pdf';

          final file = File(filename);
          await file.writeAsBytes(pdfBytes.value!.toList());

          final SaveFileDialogParams params =
              SaveFileDialogParams(sourceFilePath: file.path);
          final finalPath = await FlutterFileDialog.saveFile(params: params);
          if (finalPath != null) {
            Get.snackbar('Éxito', 'PDF guardado en $finalPath');
          }
        } else {
          // Permiso denegado, mostrar mensaje
          Get.snackbar('Permiso denegado',
              'No se puede guardar el archivo sin permisos de almacenamiento.');
        }
      } catch (e) {
        Get.snackbar('Error', 'Ocurrió un error al guardar el archivo: $e');
      }
    } else if (value == 'send') {
      final pdf = pdfBytes.value;
      final tempDir = await getTemporaryDirectory();
      final file =
          await File('${tempDir.path}/output.pdf').writeAsBytes(pdf!.toList());
      Share.shareXFiles([XFile(file.path)], text: 'Aquí tienes el PDF');
    }
  }

  void downloadPdf() async {
    // Verificar y solicitar permisos de almacenamiento
    try {
      if (await Permission.manageExternalStorage.request().isGranted) {
        // Permiso concedido, preguntar dónde guardar el archivo
        final dir = await getTemporaryDirectory();

        String filename = '${dir.path}/prueba.pdf';

        final file = File(filename);
        await file.writeAsBytes(pdfBytes.value!.toList());

        final SaveFileDialogParams params =
            SaveFileDialogParams(sourceFilePath: file.path);
        final finalPath = await FlutterFileDialog.saveFile(params: params);
        if (finalPath != null) {
          btnCntrlDescargarPdf.success();
          Get.snackbar('Éxito', 'PDF guardado en $finalPath');
          Future.delayed(Duration(seconds: 1), () {
            btnCntrlDescargarPdf.reset();
          });
        }
      } else {
        // Permiso denegado, mostrar mensaje
        Get.snackbar('Permiso denegado',
            'No se puede guardar el archivo sin permisos de almacenamiento.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al guardar el archivo: $e');
    }
  }

  void sharePdf() async {
    btnCntrlEnviarPdf.success();
     Future.delayed(Duration(seconds: 1), () {
            btnCntrlEnviarPdf.reset();
          });
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/output.pdf')
        .writeAsBytes(pdfBytes.value!.toList());
    Share.shareXFiles([XFile(file.path)], text: 'Aquí tienes el PDF');
  }
}
