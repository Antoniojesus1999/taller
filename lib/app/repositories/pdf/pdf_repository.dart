import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PdfRepository {
  final String _baseUrl = dotenv.env['URL_HOST_BACK']!;
  final String _createPdfAndView = dotenv.env['URL_CREATE_PDF']!;

  PdfRepository();

  Future<Uint8List> fetchPdfBytes(String idReparacion) async {
    String url = '$_baseUrl$_createPdfAndView'
        .replaceFirst('{idReparacion}', idReparacion);

    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/pdf'},
    );
    if (response.statusCode == 200) {
      // Verificar el tipo de contenido
      if (response.headers['content-type'] == 'application/pdf') {
        return response.bodyBytes;
      } else {
        throw Exception('El servidor no devolvió un PDF.');
      }
    } else {
      throw Exception(
          'Error al obtener el PDF: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
