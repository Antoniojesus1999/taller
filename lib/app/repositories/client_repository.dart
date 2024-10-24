import 'dart:convert';

import 'package:taller/app/data/models/client_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ClientRepository extends GetConnect {
  final Logger log = Logger();
  final String _baseUrl = dotenv.env['URL_HOST_BACK']!;
  final String _clientByIdWork = dotenv.env['URL_CLIENT_BY_ID_WORK']!;
  final String _saveClient = dotenv.env['URL_SAVE_CLIENT']!;

  Future<Cliente> saveClient(ClienteRequest client) async {
    String url = _baseUrl + _saveClient;
    log.i('Valor de client -> ${client.toString()}');
    String body = client.toRawJson();
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

  Future<ClienteRequest> getClientByIdWork(String id) async {
    log.i('Url -> $_baseUrl $_clientByIdWork');
    String url = _baseUrl + _clientByIdWork.replaceFirst("{param}", id);
    log.i('Valor de la url concatenada -> $url');

    final rsp = await get(url);
    final data = rsp.body;
    return ClienteRequest.fromJson(data);
  }
}
