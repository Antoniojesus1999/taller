import 'package:taller/app/data/models/reparacion_model_pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/services/reparacion_service.dart';
import '../../data/models/client_model.dart';
import '../../services/cliente_service.dart';

class ImageMarkerCntrl extends GetxController {
  final Logger log = Logger();
  final reparacionService = Get.find<ReparacionService>();
  final GlobalKey imageKey = GlobalKey();
  final RoundedLoadingButtonController btnCntlDanyos =
      RoundedLoadingButtonController();

  RxList<Danyo> markers = RxList<Danyo>([]);
  RxDouble imageWidth = RxDouble(0.0);
  RxDouble imageHeight = RxDouble(0.0);
  late ReparacionResponse reparacion;

  @override
  void onInit() {
    super.onInit();
    reparacion = reparacionService.reparacion;
    List<Danyo>? danyos = reparacion.danyos;
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

  void onImageLoaded() {
    final RenderBox imageBox =
        imageKey.currentContext!.findRenderObject() as RenderBox;
    imageWidth.value = imageBox.size.width;
    imageHeight.value = imageBox.size.height;
  }

  void setDataDanyos() async {
    reparacion.danyos?.addAll(markers);

    //reparacionService.saveReparacion(reparacion);
    //log.i("Valor de clientSaved $clientSaved");
  }
}