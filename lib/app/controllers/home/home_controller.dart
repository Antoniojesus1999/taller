import 'package:taller/app/services/auth_service.dart';
import 'package:taller/app/services/reparacion_service.dart';
import 'package:taller/app/services/taller_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../data/models/reparacion/reparacion.dart';

class HomeController extends GetxController {
  final Logger log = Logger();

  final ReparacionService workService;
  final AuthService authService;
  final TallerService tallerService;

  final int _limit = 10;
  int _page = 1;
  var reparaciones = <Reparacion>[];
  var hayMas = true.obs;

  HomeController({required this.workService, required this.authService, required this.tallerService});

  @override
  Future<void> onInit() async {
    super.onInit();
    await getReparaciones();
  }

  Future getReparaciones() async {
    final idTaller = tallerService.taller.id;
    try {
      List<Reparacion> rsp =
          await workService.getReparaciones(_page, _limit, idTaller);

      if (rsp.length < _limit) {
        hayMas.value = false;
      } else {
        hayMas.value = true;
      }

      reparaciones.addAll(rsp);
      _page++;
    } catch (e) {
      rethrow;
    }
  }

  Future refreshData() async {
    _page = 1;
    hayMas.value = true;
    reparaciones = [];
    await getReparaciones();
  }

  userSignOut() async {
    authService.signOut();
  }
}
