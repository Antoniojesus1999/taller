import 'dart:async';

import 'package:taller/app/data/models/taller/taller_model.dart';
import 'package:taller/app/repositories/taller_repository.dart';
import 'package:get/get.dart';

class TallerService extends GetxService {
  final TallerRepository tallerRepository;
  late String _idTaller;

  get idTaller => _idTaller;
  set setIdTaller(String idTaller) => _idTaller = idTaller;

  TallerService({required this.tallerRepository});

  Future<List<Taller>> fetchTalleres() async {
    return tallerRepository.getAllTalleres();
  }

  Future<String?> empleadoAsociadoATaller(String email) {
    return tallerRepository.tallerAsociadoEmpleado(email);
  }

  void asociandoEmailATaller(String email, String idTaller) {
    tallerRepository.asociandoEmailATaller(email, idTaller);
  }
}
