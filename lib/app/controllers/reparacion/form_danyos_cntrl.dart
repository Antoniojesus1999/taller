import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/routes/app_pages.dart';
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

  FormDanyosCntrl({
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
    btnCntlDanyos.success();
      Reparacion reparacion = await reparacionService.getReparacionById(reparacionService.reparacion.id!);
        reparacion.danyos?.assignAll(markers);
    btnCntlDanyos.reset();
    reparacion = await reparacionService.saveReparacion(reparacion);
    await captureAndSend();
    Get.toNamed(Routes.formTrabajos,
        arguments: {'idReparacion': reparacion.id});
  }

  Future<void> captureAndSend() async {
    try {
      // Usa addPostFrameCallback para asegurarte de que el árbol de widgets esté completamente renderizado
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (screenshotImage.currentContext == null) {
          throw Exception(
              "El contexto del widget es nulo. Asegúrate de que el widget esté en el árbol de widgets.");
        }

        // Obtén el RenderRepaintBoundary del widget asociado al GlobalKey
        RenderRepaintBoundary boundary = screenshotImage.currentContext!
            .findRenderObject() as RenderRepaintBoundary;

        // Verifica si el RenderRepaintBoundary necesita ser pintado
        if (boundary.debugNeedsPaint) {
          log.i("El widget necesita ser pintado. Esperando...");
          await Future.delayed(Duration(
              milliseconds: 100)); // Espera a que se complete el renderizado
        }

        // Captura la imagen del widget
        ui.Image image = await boundary.toImage();
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        // Envía la imagen al backend
        await reparacionService.sendImage(pngBytes);

        log.i("Imagen capturada y enviada correctamente.");
      });
    } catch (e) {
      // Maneja cualquier error que ocurra durante la captura o el envío
      log.e("Error en captureAndSend: $e");
    }
  }
}