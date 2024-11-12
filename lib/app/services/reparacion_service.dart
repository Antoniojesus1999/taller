import 'package:taller/app/repositories/reparacion_repository.dart';
import 'package:get/get.dart';

import '../data/models/reparacion/reparacion.dart';

class ReparacionService extends GetxService {
  final ReparacionRepository reparacionRepository;

  late Reparacion _reparacion = Reparacion();

  get reparacion => _reparacion;

  ReparacionService({required this.reparacionRepository});

  Future<List<Reparacion>> getReparaciones(
      int page, int limit, String idTaller) async {
    return reparacionRepository.getReparaciones(page, limit, idTaller);
  }

  Future<void> saveReparacion(Reparacion reparacion) async {
    _reparacion = await reparacionRepository.saveReparacion(reparacion);
    return Future.value();
  }
}
