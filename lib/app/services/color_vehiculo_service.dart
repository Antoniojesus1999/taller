import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../data/models/coches/color_vehiculo.dart';
import '../repositories/color_vehiculo_repository.dart';

class ColorVehiculoService extends GetxService {
  List<ColorVehiculo> listColores = [];
  Logger log = Logger();
  final ColorVehiculoRepository colorVehiculoRepository;

  ColorVehiculoService({required this.colorVehiculoRepository});

  Future<void> getColores() async {
    await colorVehiculoRepository.getColores().then((value) {
      listColores = value;
    });
  }
}
