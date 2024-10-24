import 'package:taller/app/data/models/request/vehiculo_request.dart';
import 'package:taller/app/data/models/response/vehiculo_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class VehiculoRepository extends GetConnect {
  final String urlHostBack = dotenv.env['URL_HOST_BACK']!;
  final String urlSaveVehiculo = dotenv.env['URL_SAVE_VEHICULO']!;
  Logger log = Logger();

  Future<VehiculoResponse> saveVehiculo(VehiculoRequest vehiculo) async {
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
            'Vehiculo guardado correctamente ${VehiculoResponse.fromJson(response.body).toString()}');
        return VehiculoResponse.fromJson(response.body);
      }
    } catch (e) {
      log.e('Error al guardar el vehiculo -> $e');
      return Future.error('Error al guardar el vehiculo -> $e');
    }
  }
}
