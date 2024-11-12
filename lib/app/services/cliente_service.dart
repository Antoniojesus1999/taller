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

  Future<void> saveCliente(Cliente cliente) async {
    final idTaller = tallerService.taller.id;
    //Inicializamos la variable para que no de error
    _cliente = await clientRepository.saveCliente(idTaller, cliente);
    return Future.value();
  }

/*  Future<ClienteRequest> getClientByIdWork(String id) {
    return clientRepository.getClientByIdWork(id);
  }*/
}
