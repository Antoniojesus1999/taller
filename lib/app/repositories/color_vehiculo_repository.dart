import 'package:taller/app/data/models/coches/color_vehiculo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ColorVehiculoRepository extends GetConnect {
  final String _urlHost = dotenv.env['URL_HOST_BACK']!;
  final String _getAllColores = dotenv.env['URL_COLOR_VEHICULO']!;
  final Logger log = Logger();

  Future<List<ColorVehiculo>> getColores() async {
    String url = "$_urlHost$_getAllColores";
    log.i('Se va a obtener todas los colores url -> $url');
    final rsp = await get(url);
    if (rsp.status.hasError) {
      log.e('Error al obtener los colores: ${rsp.statusText}');
      throw Exception('Error al obtener los colores');
    }
    final data = rsp.body;
    var result = List<ColorVehiculo>.from(data.map((e) => ColorVehiculo.fromJson(e)));
    return result;
  }
}
