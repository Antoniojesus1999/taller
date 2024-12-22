import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/models/vehiculo/vehiculo.dart';

class VehiculoRepository extends GetConnect {
  final String _baseUrl = dotenv.env['URL_HOST_BACK']!;
  final String _urlSaveVehiculo = dotenv.env['URL_SAVE_VEHICULO']!;
  final String _urlFindVehiculoByCliente =
      dotenv.env['URL_FIND_VEHICULO_BY_CLIENTE']!;
  final String _urlClienteVehiculo = dotenv.env['URL_DELETE_CLIENTE_VEHICULO']!;

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

  Future<List<Vehiculo>> getAllVehiculosByCliente(String idCliente) async {
    String url = _baseUrl +
        _urlFindVehiculoByCliente.replaceAll('{idCliente}', idCliente);
    final rsp = await get(url);

    if (rsp.statusCode == 200) {
      final data = jsonDecode(rsp.bodyString!);
      log.i('Respuesta con exito -> ${rsp.body}');
      return List<Vehiculo>.from(data.map((x) => Vehiculo.fromJson(x)));
    } else {
      // Ocurrió un error
      log.i('Error al obtener vehiculos: ${rsp.body}');
      throw Exception('Error al obtener vehiculos');
    }
  }

  Future deleteClienteVehiculo(String idCliente, String idVehiculo) async{
    String url = _baseUrl + _urlClienteVehiculo.replaceAll('{idCliente}', idCliente).replaceAll('{idVehiculo}', idVehiculo);
    final response = await delete(
      url,
    headers: {'Content-Type': 'text/plain'}, // Cambiar el Content-Type a text/plain o eliminarlo
    );

    if (response.statusCode == 200) {
      log.i('Vehículo eliminado con éxito');
    } else {
      log.i('Error al eliminar vehículo: ${response.body}');
      throw Exception('Error al eliminar vehículo');
    }
  }
  
}
