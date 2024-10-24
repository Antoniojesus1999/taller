import 'package:taller/app/data/models/request/vehiculo_request.dart';
import 'package:taller/app/data/models/response/vehiculo_response.dart';
import 'package:taller/app/repositories/vehiculo_repository.dart';
import 'package:get/get.dart';

class VehiculoService extends GetxService {
  late VehiculoResponse _vehiculo = VehiculoResponse();

  get vehiculo => _vehiculo;

  final VehiculoRepository vehiculoRepository;

  VehiculoService({required this.vehiculoRepository});

  Future<void> saveVehiculo(VehiculoRequest vehiculo) async {
    _vehiculo = await vehiculoRepository.saveVehiculo(vehiculo);
    return Future.value();
  }
}
