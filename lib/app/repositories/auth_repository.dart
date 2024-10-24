import 'package:taller/app/data/models/taller/empleado.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthRepository extends GetConnect {
  final Logger log = Logger();
  final String _baseUrl = dotenv.env['URL_HOST_BACK']!;
  final String _empleadoByUid = dotenv.env['URL_FIND_EMPLEADO_BY_UID']!;
  final String _saveEmpleado = dotenv.env['URL_SAVE_EMPLEADO']!;

  Future<Empleado> saveEmpleado(Empleado empleado) async {
    String url = _baseUrl + _saveEmpleado;
    String body = empleadoToJson(empleado);
    //String body = jsonEncode(empleado.toJson());
    log.i('se va a hacer un post a la url -> $url con el body -> $body');

    final rsp = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body,
    );

    if (rsp.statusCode == 201) {

      log.i('Respuesta obtenida al guardar empleado -> ${rsp.body}');
    
      return Empleado.fromJson(rsp.body);
    } else {
      log.f(
          'Error al guardar el empleado codigo de respuesta -> ${rsp.statusCode}: Empleado ->${empleado.toString()}');
      throw Error();
    }
  }

  Future<Empleado?> getEmpleadoByUid(String uid) async {
    String url = _baseUrl + _empleadoByUid.replaceFirst("{uid}", uid);
    log.i('Petición get a la url -> $url');
    final rsp = await get(url);
    if (rsp.statusCode == 404) {
      log.i('Error al obtener el empleado por uid: $uid');
      return null;
    }
    final data = rsp.body;
    return Empleado.fromJson(data);
  }
}
