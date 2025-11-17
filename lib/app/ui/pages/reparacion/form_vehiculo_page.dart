import 'package:taller/app/controllers/reparacion/form_vehiculo_cntl.dart';
import 'package:taller/app/data/models/coches/color_vehiculo.dart';
import 'package:taller/app/data/models/coches/marca.dart';
import 'package:taller/app/ui/global_widgets/auto_complete_custom.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taller/app/ui/global_widgets/text_field_custom.dart';

import '../../global_widgets/text_form_field_custom.dart';

class FormVehiculoPage extends StatelessWidget {
  const FormVehiculoPage({super.key});
  static List<Modelo> modelList = [];

  @override
  Widget build(BuildContext context) {

    
    final FormVehiculoController formVehiculoCntrl =
        Get.find<FormVehiculoController>();
    formVehiculoCntrl.setFormContext(context);

    final args = Get.arguments as Map<String, dynamic>?;
    formVehiculoCntrl.handleArguments(args);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del vehículo'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
        child: Form(
          key: formVehiculoCntrl.formKeyVehicle,
          child: SizedBox(
            width: Get.mediaQuery.size.width * 0.9,
            child: Obx(() => formVehiculoCntrl.changedListBrand.value &&
                    formVehiculoCntrl.changedListColor.value
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Container()),
                          SizedBox(height: Get.mediaQuery.size.height * 0.12),
                          Obx(() => TextFieldCustom(
                                controller: formVehiculoCntrl.matriculaCntrl,
                                hintText: 'Matricula',
                                textoRx: formVehiculoCntrl.textoMatriculaRx,
                                focusNode: formVehiculoCntrl.matriculaFocus,
                                readonly: formVehiculoCntrl.microActivo.value,
                                tieneFocusRx:
                                    formVehiculoCntrl.tieneFocusMatricula,
                                onClear: () => formVehiculoCntrl.clearInput(
                                    formVehiculoCntrl.matriculaCntrl,
                                    formVehiculoCntrl.textoMatriculaRx,
                                    formVehiculoCntrl.matriculaFocus),
                                onChanged: (texto) =>
                                    formVehiculoCntrl.onChangeRestInputs(
                                        texto,
                                        formVehiculoCntrl.matriculaCntrl,
                                        formVehiculoCntrl.textoMatriculaRx),
                                onTap: () => formVehiculoCntrl.onTapInputs(
                                    "matricula",
                                    formVehiculoCntrl.matriculaCntrl,
                                    formVehiculoCntrl.textoMatriculaRx,
                                    formVehiculoCntrl.matriculaFocus,
                                    formVehiculoCntrl.tieneFocusMatricula),
                              )),
                          SizedBox(height: Get.mediaQuery.size.height * 0.02),
                          AutoCompleteCustom(
                            title: 'Marcas',
                            initValue:
                                formVehiculoCntrl.valueBrandEditing.value,
                            optionsBuilder:
                                formVehiculoCntrl.obtenerOpcionesMarca,
                            displayStringForOption: (String brand) {
                              return brand;
                            },
                            onSelected: formVehiculoCntrl.handleBrandSelection,
                            onClear: () {},
                          ),
                          SizedBox(height: Get.mediaQuery.size.height * 0.02),
                          AutoCompleteCustom(
                            title: 'Modelo',
                            initValue:
                                formVehiculoCntrl.valueModelEditing.value,
                            optionsBuilder:
                                formVehiculoCntrl.obtenerOpcionesModelo,
                            displayStringForOption: (String model) {
                              return model;
                            },
                            onSelected: formVehiculoCntrl.handleModelSelection,
                            onClear: () {},
                          ),
                          SizedBox(height: Get.mediaQuery.size.height * 0.02),
                          SizedBox(
                            width: Get.mediaQuery.size.width * 0.9,
                            height: Get.mediaQuery.size.height * 0.061,
                            child: Card(
                              color: Colors.white,
                              shape: Border.all(
                                  color: Color.fromRGBO(180, 180, 180, 0.3)),
                              margin: EdgeInsets.zero,
                              child: DropdownButton<ColorVehiculo>(
                                value: formVehiculoCntrl.selectedColor.value,
                                hint: const Text('Selecciona un color'),
                                icon: const Icon(Icons.arrow_drop_down),
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                onChanged: (ColorVehiculo? colorVehiculo) =>
                                    formVehiculoCntrl
                                        .handleColorSelection(colorVehiculo!),
                                items: formVehiculoCntrl.listColores
                                    .map<DropdownMenuItem<ColorVehiculo>>(
                                        (colorInfo) {
                                  final color = Color.fromRGBO(
                                    int.parse(colorInfo.colorR!),
                                    int.parse(colorInfo.colorG!),
                                    int.parse(colorInfo.colorB!),
                                    1.0,
                                  );
                                  return DropdownMenuItem<ColorVehiculo>(
                                    value: colorInfo,
                                    child: SizedBox(
                                      width: Get.mediaQuery.size.width * 0.82,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        leading: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors
                                                  .black38, // Color del borde
                                              width: 1.0, // Grosor del borde
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.square,
                                            color: color,
                                            size: 25.0,
                                          ),
                                        ),
                                        title: Text(colorInfo.nombre!),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.mediaQuery.size.height * 0.04),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6)),
                            width: Get.mediaQuery.size.width * 0.9,
                            height: Get.mediaQuery.size.height * 0.06,
                            margin: EdgeInsets.only(left: 5),
                            child: DropdownButton<String>(
                              menuWidth: Get.mediaQuery.size.width * 0.95,
                              value:
                                  formVehiculoCntrl.selectedCombustible.value,
                              hint: const Text('Combustible'),
                              icon: const Icon(Icons.arrow_drop_down),
                              onChanged: (String? combustible) =>
                                  formVehiculoCntrl
                                      .handleCombustibleSelection(combustible!),
                              items: formVehiculoCntrl.listCombustible
                                  .map<DropdownMenuItem<String>>((combustible) {
                                return DropdownMenuItem<String>(
                                  value: combustible,
                                  child: SizedBox(
                                    width: Get.mediaQuery.size.width * 0.8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.local_gas_station,
                                            color: const Color.fromARGB(
                                                136, 0, 0, 0)),
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
                          SizedBox(height: Get.mediaQuery.size.height * 0.03),
                          Obx(() => IconButton(
                                iconSize: 40,
                                icon: Icon(
                                  formVehiculoCntrl.isListening.value
                                      ? Icons.mic
                                      : Icons.mic_none,
                                  color: formVehiculoCntrl.microActivo.value
                                      ? Colors.red
                                      : Colors.black54,
                                ),
                                onPressed: () {
                                  if (formVehiculoCntrl.microActivo.value) {
                                    FocusScope.of(context).unfocus();
                                    formVehiculoCntrl.stopListening();
                                  } else {
                                    formVehiculoCntrl.microActivo.value = true;
                                  }
                                  //formVehiculoCntrl.startListening(context);
                                },
                              )),
                          SizedBox(height: Get.mediaQuery.size.height * 0.03),
                          BtnLoad(
                            onTap: () => formVehiculoCntrl.setDataVehicle(),
                            btnController: formVehiculoCntrl.btnCntlVehicle,
                            title: 'Continuar',
                            width: Get.mediaQuery.size.width * 0.9,
                          ),
                          SizedBox(height: Get.mediaQuery.size.height * 0.02),
                        ],
                      ),
                    ),
                  ])),
          ),
        ),
      ),
    );
  }
}
