// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:taller/app/data/models/reparacion_model_pagination.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:get/get.dart';

import '../../data/models/client_model.dart';

class ReparacionDetailController extends GetxController {
  ReparacionDetailController();
  late ReparacionResponse reparacion = Get.arguments['reparacion'];
}
