import 'package:taller/app/repositories/reparacion_repository.dart';
import 'package:get/get.dart';

import '../data/models/reparacion/reparacion.dart';

class ReparacionService extends GetxService {
  final ReparacionRepository reparacionRepository;

  late Reparacion _reparacion = Reparacion();


  ReparacionService({required this.reparacionRepository});

  Reparacion get reparacion => _reparacion;

  Future<List<Reparacion>> getReparaciones(
      int page, int limit, String idTaller) async {
    return reparacionRepository.getReparaciones(page, limit, idTaller);
  }

  Future<Reparacion> saveReparacion(Reparacion reparacion) async {
    _reparacion = await reparacionRepository.saveReparacion(reparacion);
    return reparacion;
  }

  Future<void> saveTrabajo(String idReparacion, String descripcionTrabajo) async {
    return reparacionRepository.saveTrabajo(idReparacion, descripcionTrabajo);
  }

  Future<List<Trabajo>> getTrabajos(String idReparacion) async {
    return reparacionRepository.getTrabajos(idReparacion);
  }

  
}
