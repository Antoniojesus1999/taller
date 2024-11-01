// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:taller/app/data/models/reparacion_model_pagination.dart';
import 'package:get/get.dart';


class ReparacionDetailController extends GetxController {
  ReparacionDetailController();
  late ReparacionResponse reparacion = Get.arguments['reparacion'];
}
