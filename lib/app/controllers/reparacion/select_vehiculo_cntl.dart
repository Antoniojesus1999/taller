import 'package:taller/app/data/models/vehiculo/vehiculo.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:taller/app/services/vehiculo_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SelectVehiculoCntrl extends GetxController {
  final Logger log = Logger();

  //*Servicios inyectados
  final ClientService clientService;
  final VehiculoService vehiculoService;

  late List<Vehiculo> listVehiculo;

  SelectVehiculoCntrl({
    required this.clientService,
    required this.vehiculoService,
  });


  setVehiculo(Vehiculo vehiculo) {
    vehiculoService.setVehiculo = vehiculo;
  }

  void eliminarVehiculo(Vehiculo vehiculo) {
    vehiculoService.deleteClienteVehiculo(
        clientService.cliente.id!, vehiculo.id!);
  }

  void handleArguments(Map<String, dynamic>? args) {
    if (args != null) {
      if (args['listaVehiculo'] != null) {
        listVehiculo = args['listaVehiculo'];
      }
    } else {
      log.e('Ha entrado en select vehiculo sin argumentos');
    }
  }
}
