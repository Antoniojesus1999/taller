import 'package:taller/app/controllers/reparacion/form_vehiculo_cntl.dart';
import 'package:taller/app/data/models/coches/marca.dart';
import 'package:taller/app/ui/global_widgets/auto_complete_custom.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';
import 'package:taller/app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/text_form_field_custom.dart';

class FormVehiculoPage extends StatelessWidget {
  const FormVehiculoPage({super.key});
  static List<Modelo> modelList = [];
  @override
  Widget build(BuildContext context) {
    final FormVehiculoController invoiceCntrl =
        Get.find<FormVehiculoController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del vehículo'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
        child: Form(
          key: invoiceCntrl.formKeyVehicle,
          child: SizedBox(
            width: Get.mediaQuery.size.width * 0.9,
            child: Obx(() => invoiceCntrl.changedListBrand.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      TextFormFieldCustom(
                          controller: invoiceCntrl.registrationCntrl,
                          validator: (value) =>
                              Helpers.validateEmpty(value),
                          hintText: 'Matricula',
                          obscureText: false),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      AutoCompleteCustom(
                        initValue: invoiceCntrl.valueBrandEditing.value,
                        controller: invoiceCntrl.brandCntrl,
                        onSelected: invoiceCntrl.handleBrandSelection,
                        options: invoiceCntrl.listNameBrand,
                        title: 'Marcas',
                      ),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      AutoCompleteCustom(
                        initValue: invoiceCntrl.valueModelEditing.value,
                        controller: invoiceCntrl.modelCntrl,
                        onSelected: invoiceCntrl.handleModelSelection,
                        options: invoiceCntrl.modelNameList,
                        title: 'Modelo',
                      ),
/*                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      AutoCompleteCustom(
                        initValue: invoiceCntrl.valueModelEditing.value,
                        controller: invoiceCntrl.modelCntrl,
                        onSelected: invoiceCntrl.handleModelSelection,
                        options: invoiceCntrl.modelNameList,
                        title: 'Color',
                      ),*/
                      SizedBox(height: Get.mediaQuery.size.height * 0.12),
                      BtnLoad(
                          onTap: () => invoiceCntrl.setDataVehicle(),
                          btnController: invoiceCntrl.btnCntlVehicle,
                          title: 'Continuar'),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                    ],
                  )),
          ),
        ),
      ),
    );
  }
}
