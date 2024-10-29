import 'package:taller/app/data/models/reparacion_model_pagination.dart';
import 'package:taller/app/data/models/request/reparacion_model_request.dart';
import 'package:taller/app/repositories/reparacion_repository.dart';
import 'package:get/get.dart';

class ReparacionService extends GetxService {
  final ReparacionRepository reparacionRepository;

  late ReparacionResponse _reparacion = ReparacionResponse();

  ReparacionResponse get reparacion => _reparacion;

  ReparacionService({required this.reparacionRepository});

  Future<List<ReparacionResponse>> getReparaciones(
      int page, int limit, String idTaller) async {
    return reparacionRepository.getReparaciones(page, limit, idTaller);
  }

  Future<void> saveReparacion(ReparacionRequest reparacion) async {
    _reparacion = await reparacionRepository.saveReparacion(reparacion);
    return Future.value();
  }
}
