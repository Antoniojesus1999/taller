import 'package:taller/app/data/models/cliente/cliente.dart';
import 'package:taller/app/repositories/client_repository.dart';
import 'package:taller/app/services/taller_service.dart';
import 'package:get/get.dart';

class ClientService extends GetxService {
  Cliente _cliente = Cliente();

  final ClientRepository clientRepository;
  final TallerService tallerService = Get.find<TallerService>();

  ClientService({required this.clientRepository});

  Cliente get cliente => _cliente;

  Future<void> saveClient(Cliente client) async {
    String idTaller = tallerService.idTaller;
    _cliente = client;
    _cliente = await clientRepository.saveCliente(idTaller,_cliente);
    _cliente.idTaller = idTaller;
  }

  Future<Cliente> getClientByIdWork(String id) {
    return clientRepository.getClientByIdWork(id);
  }
}
