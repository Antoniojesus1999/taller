import 'package:taller/app/data/models/reparacion/reparacion.dart';
import 'package:taller/app/data/models/reparacion_model_pagination.dart';
import 'package:taller/app/repositories/reparacion_repository.dart';
import 'package:get/get.dart';

class ReparacionService extends GetxService {
  final ReparacionRepository reparacionRepository;

  late Reparacion _reparacion = Reparacion();

  Reparacion get reparacion => _reparacion;

  ReparacionService({required this.reparacionRepository});

  Future<List<ReparacionResponse>> getReparaciones(
      int page, int limit, String idTaller) async {
    return reparacionRepository.getReparaciones(page, limit, idTaller);
  }

  Future<void> saveReparacion(Reparacion reparacion) async {
    _reparacion = await reparacionRepository.saveReparacion(reparacion);
    return Future.value();
  }
}
