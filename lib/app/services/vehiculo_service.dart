import 'package:taller/app/repositories/vehiculo_repository.dart';
import 'package:get/get.dart';
import 'package:taller/app/services/taller_service.dart';

import '../data/models/vehiculo/vehiculo.dart';
import 'cliente_service.dart';

class VehiculoService extends GetxService {
  late Vehiculo _vehiculo = Vehiculo();

  get vehiculo => _vehiculo;

  final VehiculoRepository vehiculoRepository;

  final ClientService clienteService = Get.find<ClientService>();

  VehiculoService({required this.vehiculoRepository});

  Future<void> saveVehiculo(Vehiculo vehiculo) async {
    final idCliente = clienteService.cliente.id;
    _vehiculo = await vehiculoRepository.saveVehiculo(idCliente!, vehiculo);
    return Future.value();
  }
}
