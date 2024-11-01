import 'package:taller/app/data/models/response/vehiculo.dart';
import 'package:taller/app/repositories/vehiculo_repository.dart';
import 'package:get/get.dart';

class VehiculoService extends GetxService {
  late Vehiculo _vehiculo = Vehiculo();

  get vehiculo => _vehiculo;

  final VehiculoRepository vehiculoRepository;

  VehiculoService({required this.vehiculoRepository});

  Future<void> saveVehiculo(Vehiculo vehiculo) async {
    _vehiculo = await vehiculoRepository.saveVehiculo(vehiculo);
    return Future.value();
  }
}
