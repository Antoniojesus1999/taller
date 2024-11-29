import 'package:get/get.dart';
import '../../data/models/reparacion/reparacion.dart';

class ReparacionDetailController extends GetxController {
  ReparacionDetailController();
  late Reparacion reparacion = Get.arguments['reparacion'];
}
