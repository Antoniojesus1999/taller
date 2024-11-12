import 'dart:async';

import 'package:taller/app/data/models/taller/taller.dart';
import 'package:taller/app/repositories/taller_repository.dart';
import 'package:get/get.dart';

class TallerService extends GetxService {
  final TallerRepository tallerRepository;
  late Taller _taller;

  get taller => _taller;
  set setTaller(Taller taller) => _taller = taller;

  TallerService({required this.tallerRepository});

  Future<List<Taller>> fetchTalleres() async {
    return tallerRepository.getAllTalleres();
  }

  Future<Taller?> empleadoAsociadoATaller(String email) async {
    return await tallerRepository.tallerAsociadoEmpleado(email);
  }

  void asociandoEmailATaller(String email, String idTaller) {
    tallerRepository.asociandoEmailATaller(email, idTaller);
  }
}
