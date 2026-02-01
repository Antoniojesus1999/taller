import 'package:get/get.dart';
import 'package:taller/app/controllers/reparacion/form_datos_adicionales_cntrl.dart';
import 'package:taller/app/services/cliente_service.dart';
import '../repositories/client_repository.dart';

class FormDatosAdicionalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientRepository>(() => ClientRepository());
    Get.lazyPut(() => ClientService(clientRepository: Get.find()));
    Get.lazyPut<FormDatosAdicionalesCntrl>(() => FormDatosAdicionalesCntrl(
      reparacionService: Get.find(), microService: Get.find(),
    ));
  }
}
