import 'dart:typed_data';

import 'package:taller/app/repositories/pdf/pdf_repository.dart';
import 'package:taller/app/repositories/reparacion_repository.dart';
import 'package:get/get.dart';

import '../data/models/reparacion/reparacion.dart';

class PdfService extends GetxService {
  final PdfRepository pdfRepository;

  PdfService({required this.pdfRepository});

  Future<Uint8List> createPdf(String idReparacion) async {
    return await pdfRepository.fetchPdfBytes(idReparacion);
  }
}
