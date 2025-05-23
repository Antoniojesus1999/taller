import 'package:flutter/material.dart';
import 'package:taller/app/data/models/vehiculo/vehiculo.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:taller/app/services/reparacion_service.dart';
import 'package:taller/app/services/vehiculo_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../data/models/reparacion/reparacion.dart';
import '../../routes/app_pages.dart';
import '../../utils/snack_bar.dart';

class SelectVehiculoCntrl extends GetxController {
  final Logger log = Logger();

  //*Servicios inyectados
  final ClientService clientService;
  final VehiculoService vehiculoService;
  final ReparacionService reparacionService;

  late List<Vehiculo> listVehiculo;

  SelectVehiculoCntrl({
    required this.clientService,
    required this.vehiculoService,
    required this.reparacionService,
  });


  setVehiculo(Vehiculo vehiculo) {
    vehiculoService.setVehiculo = vehiculo;

    bool encontrado = false;
    List<Reparacion> reparaciones = reparacionService.reparaciones;
    for (Reparacion rep in reparaciones) {
      if (rep.vehiculo?.matricula == vehiculo.matricula) {
        encontrado = true;
        break;
      }
    }

    if (encontrado) {
      openSnackbar(Get.context, 'Ya existe una reparación en curso para este vehiculo', Colors.red);
    } else {
      Get.toNamed(Routes.formVehicle,
          arguments: {'from': 'fromSelectVehicle'});
    }
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
