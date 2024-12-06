import 'package:taller/app/data/models/coches/marca.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MarcasRepository extends GetConnect {
  final String _urlHost = dotenv.env['URL_HOST_BACK']!;
  final String _getAllMarcas = dotenv.env['URL_FIND_ALL_MARCAS']!;
  final Logger log = Logger();

  Future<List<Marca>> getMarcas() async {
    String url = "$_urlHost$_getAllMarcas"
        .replaceAll('{page}', 0.toString())
        .replaceAll('&limit={limit}', '');
    log.i('Se va a obtener todas las marcas url -> $url');
    final rsp = await get(url);
    if (rsp.status.hasError) {
      log.e('Error al obtener las marcas: ${rsp.statusText}');
      throw Exception('Error al obtener las marcas');
    }
    final data = rsp.body;
    var result = List<Marca>.from(data.map((e) => Marca.fromJson(e)));
    return result;
  }
}
