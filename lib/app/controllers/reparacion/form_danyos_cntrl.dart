import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/services/reparacion_service.dart';
import '../../data/models/reparacion/reparacion.dart';

class FormDanyosCntrl extends GetxController {
  final Logger log = Logger();
  final GlobalKey imageKey = GlobalKey();
  final RoundedLoadingButtonController btnCntlDanyos =
      RoundedLoadingButtonController();

  RxList<Danyo> markers = RxList<Danyo>([]);
  RxDouble imageWidth = RxDouble(0.0);
  RxDouble imageHeight = RxDouble(0.0);
  RxBool isLoading = RxBool(false);

  //*Servicios inyectados
  final ReparacionService reparacionService;

  ImageMarkerCntrl({
    required this.reparacionService,
  });

  @override
  void onInit() {
    super.onInit();
    List<Danyo>? danyos = reparacionService.reparacion.danyos;
    if (danyos != null && danyos.isNotEmpty) {
      markers.addAll(danyos);
    }
  }

  void addMarker(Offset position) {
    markers.add(Danyo(
      positionX: position.dx,
      positionY: position.dy,
      origWidth: imageWidth.value,
      origHeight: imageHeight.value,
    ));
  }

  void removeMarker(Danyo marker) {
    markers.remove(marker);
  }

  Future<void> onImageLoaded() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox imageBox = imageKey.currentContext!.findRenderObject() as RenderBox;
      imageWidth.value = imageBox.size.width;
      imageHeight.value = imageBox.size.height;
    });
  }

  void setDataDanyos() async {
    Reparacion reparacion = reparacionService.reparacion;
    reparacion.danyos?.addAll(markers);

    reparacionService.saveReparacion(reparacion);

  }
}