import 'package:taller/app/controllers/reparacion/form_datos_adicionales_cntrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/btn_load.dart';
import '../../global_widgets/text_form_field_custom.dart';

// ignore: must_be_immutable
class FormDatosAdicionalesPage extends StatelessWidget {
  const FormDatosAdicionalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FormDatosAdicionalesCntrl datosAdicionalesCntrl =
        Get.find<FormDatosAdicionalesCntrl>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos adicionales del vehículo'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
          minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
          child: Form(
              key: datosAdicionalesCntrl.formKeyDatosAdecionales,
              child: SizedBox(
                width: Get.mediaQuery.size.width * 0.9,
                child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: Get.mediaQuery.size.height * 0.02),
                            
                            TextFormFieldCustom(
                                controller: datosAdicionalesCntrl.kilometrosCntrl,
                                hintText: 'Kms',
                                obscureText: false,
                                keyboardType:
                                    TextInputType.numberWithOptions(decimal: true)),
                            SizedBox(height: Get.mediaQuery.size.height * 0.12),
                            BtnLoad(
                              onTap: () => datosAdicionalesCntrl.setDatosAdicionales(),
                              btnController: datosAdicionalesCntrl.btnCntlDatosAdicionales,
                              title: 'Continuar',
                              width: Get.mediaQuery.size.width * 0.9,
                            ),
                            SizedBox(height: Get.mediaQuery.size.height * 0.02),
                          ],
                      ),
                  ),
                ]),
              ),
            ),
          ),
    );
  }
}
