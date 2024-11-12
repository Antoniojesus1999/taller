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
}
