import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:taller/app/repositories/reparacion_repository.dart';
import 'package:get/get.dart';

import '../data/models/reparacion/reparacion.dart';

class ReparacionService extends GetxService {
  final Logger log = Logger();
  final ReparacionRepository reparacionRepository;

  late Reparacion _reparacion = Reparacion();
  late List<Reparacion> _reparaciones = [];

  ReparacionService({required this.reparacionRepository});

  Reparacion get reparacion => _reparacion;
  List<Reparacion> get reparaciones => _reparaciones;

  Future<List<Reparacion>> getReparaciones(
      int page, int limit, String idTaller) async {
    _reparaciones = await reparacionRepository.getReparaciones(page, limit, idTaller);
    return _reparaciones;
  }

  Future<Reparacion> saveReparacion(Reparacion reparacion) async {
    _reparacion = await reparacionRepository.saveReparacion(reparacion);
    return reparacion;
  }

  Future<void> saveTrabajo(
      String idReparacion, String descripcionTrabajo) async {
    return reparacionRepository.saveTrabajo(idReparacion, descripcionTrabajo);
  }

  Future<List<Trabajo>> getTrabajos(String idReparacion) async {
    return reparacionRepository.getTrabajos(idReparacion);
  }

  Future<Reparacion> getReparacionById(String id) async {
    return reparacionRepository.getReparacionById(id);
  }

  Future<void> sendImage(Uint8List base64Image) async {
    log.i('se va a enviar la imagen NIF -> ${reparacion.cliente!.nif}');
    reparacionRepository.sendImageToServer('${reparacion.id!}.png', base64Image);
  }
}
