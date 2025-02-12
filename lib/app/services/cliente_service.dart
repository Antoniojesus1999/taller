import 'package:taller/app/data/models/cliente/cliente.dart';
import 'package:taller/app/repositories/client_repository.dart';
import 'package:taller/app/services/taller_service.dart';
import 'package:get/get.dart';

class ClientService extends GetxService {
  late Cliente _cliente = Cliente();
  late List<Cliente> _clientes;

  final ClientRepository clientRepository;
  final TallerService tallerService = Get.find<TallerService>();

  ClientService({required this.clientRepository});

  Cliente get cliente => _cliente;
  //Clientes de un taller
  List<Cliente> get clientes => _clientes;

  Future<void> saveCliente(Cliente cliente) async {
    final idTaller = tallerService.taller.id;
    //Inicializamos la variable para que no de error
    _cliente = await clientRepository.saveCliente(idTaller, cliente);
    return Future.value();
  }

  Future<List<Cliente>> getAllClientsByTaller() async {
    final idTaller = tallerService.taller.id;
    _clientes =  await clientRepository.getAllClientsByTaller(idTaller);
    return _clientes;
  }
}
