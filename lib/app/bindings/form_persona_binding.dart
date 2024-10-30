import 'package:get/get.dart';
import 'package:taller/app/controllers/reparacion/form_persona_cntrl.dart';
import 'package:taller/app/services/cliente_service.dart';

import '../repositories/client_repository.dart';

class FormPersonaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientRepository>(() => ClientRepository());
    Get.lazyPut(() => ClientService(clientRepository: Get.find()));
    Get.lazyPut<FormPersonaCntrl>(() => FormPersonaCntrl(
        clientService: Get.find()));
  }
}
