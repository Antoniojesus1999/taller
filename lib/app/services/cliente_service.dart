import 'package:taller/app/data/models/client_model.dart';
import 'package:taller/app/data/models/cliente/cliente_model.dart';
import 'package:taller/app/repositories/client_repository.dart';
import 'package:taller/app/services/taller_service.dart';
import 'package:get/get.dart';

class ClientService extends GetxService {
  ClienteRequest _clienteRequest = ClienteRequest();
  ClienteModel _clienteModel = ClienteModel();

  final ClientRepository clientRepository;
  final TallerService tallerService = Get.find<TallerService>();

  ClientService({required this.clientRepository});

  ClienteRequest get cliente => _clienteRequest;
  ClienteModel get clienteModel => _clienteModel;

  Future<void> saveClient(ClienteRequest client) async {
    client.idTaller = tallerService.idTaller;
    //Inicializamos la variable para que no de error
    _clienteRequest =
        ClienteRequest(idTaller: client.idTaller, cliente: client.cliente);
    Cliente cliente = await clientRepository.saveClient(client);
    //Asignamos al cliente el valor del id que nos devuelve el back
    _clienteRequest.cliente = client.cliente;
    _clienteRequest.cliente = cliente;
    return Future.value();
  }

  Future<void> saveClienteModel(ClienteModel cliente) async {
    final idTaller = tallerService.idTaller;
    //Inicializamos la variable para que no de error
    _clienteModel = await clientRepository.saveClienteModel(idTaller, cliente);
    return Future.value();
  }

  Future<ClienteRequest> getClientByIdWork(String id) {
    return clientRepository.getClientByIdWork(id);
  }
}
