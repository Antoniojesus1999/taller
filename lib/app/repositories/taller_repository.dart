import 'dart:convert';

import 'package:taller/app/data/models/taller/taller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/connect.dart';
import 'package:logger/logger.dart';

class TallerRepository extends GetConnect {
  final Logger log = Logger();
  final String _baseUrl = dotenv.env['URL_HOST_BACK']!;
  final String _findAllTaller = dotenv.env['URL_FIND_ALL_TALLER']!;
  final String _existTallerByEmailEmpleado =
      dotenv.env['URL_GET_FIND_TALLER_BY_EMAIL_EMPLEADO']!;
  final String _putAddEmailEmpleadoTaller =
      dotenv.env['URL_PUT_ADD_EMAIL_EMPLADO_TALLER']!;

  Future<List<Taller>> getAllTalleres() async {
    try {
      //*Ponemos 0 para que no lo devuelva paginado
      final response = await get("$_baseUrl$_findAllTaller?page=0");
      if (response.statusCode == 200) {
        // Convertimos el String a una lista de objetos JSON
        return List.from(response.body.map((json) => Taller.fromJson(json)));
      } else {
        throw Exception('Failed to load talleres');
      }
    } catch (e) {
      throw Exception('Error al obtener talleres: $e');
    }
  }

  Future<Taller> tallerAsociadoEmpleado(String email) async {
    Response<dynamic> rsp = Response();
    try {
      rsp = await get("$_baseUrl$_existTallerByEmailEmpleado?email=$email");
      if (rsp.statusCode == 200) {
        final data = jsonDecode(rsp.bodyString!);
        //Devolvemos el id del taller
        return Taller.fromJson(data);
      } else if (rsp.statusCode == 404) {
        return Taller();
      } else {
        throw Exception('Fallo al ver si un empleado tiene asociado un taller');
      }
    } catch (e) {
      throw Exception(
          'Error al obtener si un usuario tiene asociado un taller: $e');
    }
  }

  Future<Taller> asociandoEmailATaller(String email, String idTaller) async {
    try {
      log.i(
          'Petición a /taller/add-empleado-taller email: $email idTaller: $idTaller');
      final response = await put(
        '$_baseUrl$_putAddEmailEmpleadoTaller',
        {'idTaller': idTaller, 'email': email},
      );

      log.i('Petición de asociar email a taller -> ${response.statusCode}');
      if (response.statusCode == 200) {
        Taller taller = Taller.fromJson(response.body);
        return taller;
      } else {
        throw Exception(
            'Back a devuelto un codigo distinto a 200 ok: $response');
      }
    } catch (e) {
      throw Exception('Error al asociar un email al taller: $e');
    }
  }
}
