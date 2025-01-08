import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/models/reparacion/reparacion.dart';
import '../data/models/response/pagination_response.dart';

class ReparacionRepository extends GetConnect {
  final String _urlHost = dotenv.env['URL_HOST_BACK']!;
  final String _urlFindReparacionesByTaller =
      dotenv.env['URL_FIND_REPARACIONES_BY_TALLER']!;
  final String _urlSaveReparacion = dotenv.env['URL_SAVE_REPARACION']!;
  final String _urlSaveTrabajo = dotenv.env['URL_SAVE_TRABAJO']!;
  final String _urlGetTrabajo = dotenv.env['URL_GET_TRABAJOS']!;
  final Logger log = Logger();

  Future<List<Reparacion>> getReparaciones(
      int page, int limit, String idTaller) async {
    String url = "$_urlHost$_urlFindReparacionesByTaller"
        .replaceAll('{idTaller}', idTaller)
        .replaceAll('{page}', page.toString())
        .replaceAll('{limit}', limit.toString());

    final rsp = await get(url);
    final data = rsp.body;
    final paginationResponse = PaginationResponse<Reparacion>.fromJson(
      data,
      (json) => Reparacion.fromJson(json),
    );

    return paginationResponse.docs!;
  }

  Future<Reparacion> saveReparacion(
      Reparacion reparacion) async {
    String url = _urlHost + _urlSaveReparacion;
    log.i(
        'Se va a guardar la reparacion url $url body -> ${reparacion.toRawJson()}');
    try {
      final response = await post(url, reparacion.toRawJson());
      if (response.statusCode != 201) {
        log.e('Error al guardar la reparacion -> ${response.statusText}');
        return Future.error(
            'Error al guardar la reparacion codigo -> ${response.statusCode}');
      } else {
        log.i('Reparacion guardada correctamente ${reparacion.toString()}');
        return Reparacion.fromJson(response.body);
      }
    } catch (e) {
      log.e('Error al guardar la reparacion -> $e');
      return Future.error('Error al guardar la reparacion -> $e');
    }
  }

  Future<void> saveTrabajo(
      String idReparacion, String descripcionTrabajo) async {
    String url = _urlHost + _urlSaveTrabajo.replaceFirst('{idReparacion}', idReparacion);
    log.i(
        'Se va a guardar la descripción del trabajo  url $url body -> ${[descripcionTrabajo]}');
    try {
      final response = await put(url, [descripcionTrabajo]);
      if (response.statusCode != 200) {
        log.e('Error al guardar el trabajo -> ${response.statusText}');
        return Future.error(
            'Error al guardar el trabajo codigo -> ${response.statusCode}');
      }
    } catch (e) {
      log.e('Error al guardar el trabajo -> $e');
      return Future.error('Error al guardar el trabajo -> $e');
    }
  }

  Future<List<Trabajo>> getTrabajos(String idReparacion) async {
    String url = _urlHost + _urlGetTrabajo.replaceFirst('{idReparacion}', idReparacion);
    log.i('Se va a obtener los trabajos de la reparacion url $url');
    try {
      final response = await get(url);
      if (response.statusCode != 200) {
        log.e('Error al obtener los trabajos -> ${response.statusText}');
        return Future.error(
            'Error al obtener los trabajos codigo -> ${response.statusCode}');
      } else {
        log.i('Trabajos obtenidos correctamente ${response.body}');
        return List<Trabajo>.from(response.body.map((x) => Trabajo.fromJson(x)));
      }
    } catch (e) {
      log.e('Error al obtener los trabajos -> $e');
      return Future.error('Error al obtener los trabajos -> $e');
    }
  }
}
