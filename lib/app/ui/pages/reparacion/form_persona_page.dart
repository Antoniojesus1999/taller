import 'package:taller/app/controllers/home/home_controller.dart';
import 'package:taller/app/controllers/reparacion/form_persona_cntrl.dart';
import 'package:taller/app/data/models/cliente/cliente.dart';
import 'package:taller/app/ui/global_widgets/auto_complete_custom.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/text_field_custom.dart';
import '../../global_widgets/text_form_field_custom.dart';

// ignore: must_be_immutable
class FormPersonaPage extends StatelessWidget {
  const FormPersonaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FormPersonaCntrl personaCntrl = Get.find<FormPersonaCntrl>();
    final homeCntrl = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de cliente'),
        leading: BackButton(onPressed: (){
          homeCntrl.refreshData();
          Get.back();
        }),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
        child: Form(
          key: personaCntrl.formKeyPerson,
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
                      Obx(() {
                        if (personaCntrl.microActivo.value) {
                          return CompositedTransformTarget(
                            link:personaCntrl.nifFieldLink,
                            child: TextFieldCustom(
                              controller: personaCntrl.nifCntrl,
                              title: 'NIF',
                            ),
                          );
                        } else {
                          return AutoCompleteCustom(
                            title: 'NIF',
                            optionsBuilder: personaCntrl.obtenerOpcionesNif,
                            displayStringForOption: (String option) {return option;},
                            onSelected: personaCntrl.onClienteSeleccionado,
                            onSubmitted: (String value) {personaCntrl.nifCntrl.text = value;},
                          );
                        }
                      }),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      TextFormFieldCustom(
                          controller: personaCntrl.nameCntrl,
                          hintText: 'Nombre',
                          obscureText: false,
                          focusNode: personaCntrl.nameFocus),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      TextFormFieldCustom(
                          controller: personaCntrl.surName1Cntrl,
                          hintText: 'Primer apellido',
                          obscureText: false,
                          focusNode: personaCntrl.surName1Focus),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      TextFormFieldCustom(
                          controller: personaCntrl.surName2Cntrl,
                          hintText: 'Segundo apellido',
                          obscureText: false,
                          focusNode: personaCntrl.surName2Focus),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      TextFormFieldCustom(
                          controller: personaCntrl.emailCntrl,
                          //validator: (value) => Helpers.validateEmail(value),
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          focusNode: personaCntrl.emailFocus),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      TextFormFieldCustom(
                          controller: personaCntrl.tlfCntrl,
                          hintText: 'Telefono',
                          obscureText: false,
                          focusNode: personaCntrl.tlfFocus),
                      SizedBox(height: Get.mediaQuery.size.height * 0.05),
                      Obx(() => IconButton(
                        iconSize: 40,
                        icon: Icon(
                          personaCntrl.isListening.value ? Icons.mic : Icons.mic_none,
                          color: personaCntrl.isListening.value ? Colors.red : Colors.black54,
                        ),
                        onPressed: () {
                          personaCntrl.startListening(context);
                        },
                      )),
                      SizedBox(height: Get.mediaQuery.size.height * 0.06),
                      BtnLoad(
                          onTap: () => personaCntrl.setDataPersona(),
                          btnController: personaCntrl.btnCntlPerson,
                          title: 'Continuar',
                          width: Get.mediaQuery.size.width * 0.9,
                      ),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
