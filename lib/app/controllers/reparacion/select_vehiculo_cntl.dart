import 'package:taller/app/services/cliente_service.dart';
import 'package:taller/app/services/vehiculo_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


class SelectVehiculoController extends GetxController {
  
  final Logger log = Logger();

  //*Servicios inyectados
  final ClientService clientService;
  final VehiculoService vehiculoService;

  SelectVehiculoController({
    required this.clientService,
    required this.vehiculoService,
  });

  @override
  void onInit() {
    super.onInit();
  }

  
}
