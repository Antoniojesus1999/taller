import 'package:taller/app/repositories/vehiculo_repository.dart';
import 'package:get/get.dart';

import '../data/models/vehiculo/vehiculo.dart';
import 'cliente_service.dart';

class VehiculoService extends GetxService {
  late Vehiculo _vehiculo = Vehiculo();

  get vehiculo => _vehiculo;
  set setVehiculo(Vehiculo vehiculo) => _vehiculo = vehiculo;

  final VehiculoRepository vehiculoRepository;

  final ClientService clienteService = Get.find<ClientService>();

  VehiculoService({required this.vehiculoRepository});

  Future<void> saveVehiculo(Vehiculo vehiculo) async {
    final idCliente = clienteService.cliente.id;
    _vehiculo = await vehiculoRepository.saveVehiculo(idCliente!, vehiculo);
    return Future.value();
  }
  Future<List<Vehiculo>> getAllVehiculosByCliente(String idCliente) async {
    return await vehiculoRepository.getAllVehiculosByCliente(idCliente);
  }
  Future<void> deleteClienteVehiculo(String idCliente, String idVehiculo) async {
    await vehiculoRepository.deleteClienteVehiculo(idCliente,idVehiculo);
    return Future.value();
  }
}
