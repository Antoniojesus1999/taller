// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:taller/app/data/models/taller/taller.dart';
import 'package:taller/app/routes/app_pages.dart';
import 'package:taller/app/services/auth_service.dart';
import 'package:taller/app/services/taller_service.dart';

class TallerCntrl extends GetxController {
  final Logger log = Logger();
  final TallerService tallerService;
  final AuthService authService;

  final searchText = ''.obs;
  final listaFiltradaTalleres = <Taller>[].obs;
  List<Taller> listaTalleres = [];

  TallerCntrl({
    required this.tallerService,
    required this.authService,
  });

  @override
  void onInit() async {
    super.onInit();
    listaTalleres = await tallerService.fetchTalleres();
    listaFiltradaTalleres.value = listaTalleres;

    filter();
  }

  void filter() {
    ever(searchText, (value) {
      listaFiltradaTalleres.value = listaTalleres;
      listaFiltradaTalleres.value = listaFiltradaTalleres
          .where((taller) =>
              taller.nombre!.toLowerCase().contains(value.toLowerCase()) ||
              taller.cif!.toLowerCase().contains(value.toLowerCase()) ||
              taller.municipio!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void asociandoEmailATaller(String idTaller) {
    String email = authService.firebaseUser!.email!;

    tallerService
        .asociandoEmailATaller(email, idTaller)
        .then((taller) {
          tallerService.setTaller = taller;
        });
    Get.toNamed(Routes.home);
  }
  /*@override
  Future<void> onInit() async {
    talleres = tallerService.getAllTalleres();
    final SharedPreferences s = await SharedPreferences.getInstance();
    log.d('SharedPreferences -> $s');
    log.d('Name -> ${s.getString('name')}');
    log.d('Email -> ${s.getString('email')}');
    log.d('Image -> ${s.getString('image_url')}');
    log.d('Uid -> ${s.getString('uid')!}');
    log.d('provider -> ${s.getString('provider')}');
    super.onInit();
  }*/
}
