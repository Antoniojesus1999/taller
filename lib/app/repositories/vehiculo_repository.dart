import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/models/vehiculo/vehiculo.dart';

class VehiculoRepository extends GetConnect {
  final String urlHostBack = dotenv.env['URL_HOST_BACK']!;
  final String urlSaveVehiculo = dotenv.env['URL_SAVE_VEHICULO']!;
  Logger log = Logger();

  Future<Vehiculo> saveVehiculo(Vehiculo vehiculo) async {
    log.i('Se va a guardar el vehiculo -> ${vehiculo.toString()}');
    try {
      final response =
          await post('$urlHostBack$urlSaveVehiculo', vehiculo.toJson());
      if (response.statusCode != 201) {
        log.e('Error al guardar el vehiculo -> ${response.statusText}');
        return Future.error(
            'Error al guardar el vehiculo codigo -> ${response.statusCode}');
      } else {
        log.i(
            'Vehiculo guardado correctamente ${Vehiculo.fromJson(response.body).toString()}');
        return Vehiculo.fromJson(response.body);
      }
    } catch (e) {
      log.e('Error al guardar el vehiculo -> $e');
      return Future.error('Error al guardar el vehiculo -> $e');
    }
  }
}
