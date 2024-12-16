import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/models/vehiculo/vehiculo.dart';

class VehiculoRepository extends GetConnect {
  final String _baseUrl = dotenv.env['URL_HOST_BACK']!;
  final String _urlSaveVehiculo = dotenv.env['URL_SAVE_VEHICULO']!;
  Logger log = Logger();

  Future<Vehiculo> saveVehiculo(String idCliente, Vehiculo vehiculo) async {
    String url = _baseUrl + _urlSaveVehiculo;
    log.i('Se va a guardar el vehiculo -> ${vehiculo.toString()}');
    final body = json.encode({
      "idCliente": idCliente,
      "vehiculo": vehiculo.toJson(), // Convertimos ClienteModel a JSON
    });

    final rsp = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body,
    );

    if (rsp.statusCode == 201) {
      final data = jsonDecode(rsp.bodyString!);
      log.i('Respuesta con exito -> ${rsp.body}');
      return Vehiculo.fromJson(data);
    } else {
      // Ocurrió un error
      log.i('Error al guardar vehiculo: ${rsp.body}');
      throw Exception('Error al guardar vehiculo');
    }
  }
}
