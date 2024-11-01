import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/models/cliente/cliente_model.dart';

class ClientRepository extends GetConnect {
  final Logger log = Logger();
  final String _baseUrl = dotenv.env['URL_HOST_BACK']!;
  final String _clientByIdWork = dotenv.env['URL_CLIENT_BY_ID_WORK']!;
  final String _saveClient = dotenv.env['URL_SAVE_CLIENT']!;

  

  Future<Cliente> saveCliente(String idTaller, Cliente cliente) async {
    String url = _baseUrl + _saveClient;
    final body = json.encode({
      "idTaller": idTaller,
      "cliente": cliente.toJson(), // Convertimos ClienteModel a JSON
    });
    log.i('Se va a guardar un cliente -> $url con el body -> $body');

    final rsp = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body,
    );

    if (rsp.statusCode == 201) {
      final data = jsonDecode(rsp.bodyString!);
      log.i('Respuesta con exito -> ${rsp.body}');
      return Cliente.fromJson(data);
    } else {
      // Ocurrió un error
      log.i('Error al guardar el cliente: ${rsp.body}');
      throw Exception('Error al guardar el cliente');
    }
  }

  Future<Cliente> getClientByIdWork(String id) async {
    log.i('Url -> $_baseUrl $_clientByIdWork');
    String url = _baseUrl + _clientByIdWork.replaceFirst("{param}", id);
    log.i('Valor de la url concatenada -> $url');

    final rsp = await get(url);
    final data = rsp.body;
    return Cliente.fromJson(data);
  }
}
