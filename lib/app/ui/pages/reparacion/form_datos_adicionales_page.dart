import 'package:taller/app/controllers/reparacion/form_datos_adicionales_cntrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          child: Obx(
            () => Form(
              key: datosAdicionalesCntrl.formKeyDatosAdecionales,
              child: SizedBox(
                width: Get.mediaQuery.size.width * 0.9,
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: Get.mediaQuery.size.height * 0.02),
                        SizedBox(
                          width: Get.mediaQuery.size.width * 0.9,
                          //height: Get.mediaQuery.size.height * 0.050,
                          child: Card(
                            color: Colors.white,
                            shape: Border.all(
                                color: Color.fromRGBO(180, 180, 180, 0.3)),
                            margin: EdgeInsets.zero,
                            child: Center(
                              child: DropdownButton<String>(
                                value: datosAdicionalesCntrl
                                    .selectedCombustible.value,
                                hint: const Text('Combustible'),
                                icon: const Icon(Icons.arrow_drop_down),
                                underline: Container(
                                  height: 1,
                                  color: Colors.red,
                                ),
                                //menuWidth: Get.mediaQuery.size.width * 0.8,
                                
                                onChanged: (String? combustible) =>
                                    datosAdicionalesCntrl
                                        .handleCombustibleSelection(combustible!),
                                items: datosAdicionalesCntrl.listCombustible
                                    .map<DropdownMenuItem<String>>((combustible) {
                                  return DropdownMenuItem<String>(
                                    value: combustible,
                                    child: SizedBox(
                                      width: Get.mediaQuery.size.width * 0.8,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.local_gas_station,
                                              color: const Color.fromARGB(136, 0, 0, 0)),
                                          SizedBox(width: 10),
                                          Text(
                                            combustible,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.mediaQuery.size.height * 0.02),
                        TextFormFieldCustom(
                            controller: datosAdicionalesCntrl.kilometrosCntrl,
                            hintText: 'Kms',
                            obscureText: false,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true)),
                        SizedBox(height: Get.mediaQuery.size.height * 0.12),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}
