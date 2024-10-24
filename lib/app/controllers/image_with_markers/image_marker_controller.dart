/* import 'package:taller/app/data/models/reparacion_model_pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../data/models/client_model.dart';
import '../../services/cliente_service.dart';

class ImageMarkerController extends GetxController {
  final Logger log = Logger();
  final clientService = Get.find<ClientService>();
  final GlobalKey imageKey = GlobalKey();
  final RoundedLoadingButtonController btnCntlDanyos =
      RoundedLoadingButtonController();

  RxList<Danyo> markers = RxList<Danyo>([]);
  RxDouble imageWidth = RxDouble(0.0);
  RxDouble imageHeight = RxDouble(0.0);

  @override
  void onInit() {
    super.onInit();
    List<Danyo>? danyos =
        clientService.clientDto.vehicles?[0].repairs![0].danyos;
    if (danyos != null && danyos.isNotEmpty) {
      markers.addAll(danyos);
    }
  }

  void addMarker(Offset position) {
    markers.add(Danyo(
      position: position,
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
    clientService.clientDto.vehicles![0].repairs?[0].danyos?.addAll(markers);

    Future<Cliente?> clientSaved =
        clientService.saveClient(clientService.clientDto);
    log.i("Valor de clientSaved $clientSaved");
    //Get.toNamed(Routes.invoiceVehicle);
  }
}
 */