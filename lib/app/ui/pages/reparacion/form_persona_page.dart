import 'package:taller/app/controllers/reparacion/form_persona_cntrl.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';
import 'package:taller/app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/text_form_field_custom.dart';

// ignore: must_be_immutable
class FormPersonaPage extends StatelessWidget {
  const FormPersonaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FormPersonaCntrl personaCntrl = Get.find<FormPersonaCntrl>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de cliente'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
        child: Form(
          key: personaCntrl.formKeyPerson,
          child: SizedBox(
            width: Get.mediaQuery.size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: Get.mediaQuery.size.height * 0.02),
                TextFormFieldCustom(
                    controller: personaCntrl.nifCntrl,
                    validator: (value) => Helpers.validateEmpty(value),
                    hintText: 'NIF',
                    obscureText: false),
                SizedBox(height: Get.mediaQuery.size.height * 0.02),
                TextFormFieldCustom(
                    controller: personaCntrl.nameCntrl,
                    hintText: 'Nombre',
                    obscureText: false),
                SizedBox(height: Get.mediaQuery.size.height * 0.02),
                TextFormFieldCustom(
                    controller: personaCntrl.surName1Cntrl,
                    hintText: 'Primer apellido',
                    obscureText: false),
                SizedBox(height: Get.mediaQuery.size.height * 0.02),
                TextFormFieldCustom(
                    controller: personaCntrl.surName2Cntrl,
                    hintText: 'Segundo apellido',
                    obscureText: false),
                SizedBox(height: Get.mediaQuery.size.height * 0.02),
                TextFormFieldCustom(
                    controller: personaCntrl.emailCntrl,
                    //validator: (value) => Helpers.validateEmail(value),
                    hintText: 'Email',
                    keyboardTypeEmail: TextInputType.emailAddress,
                    obscureText: false),
                SizedBox(height: Get.mediaQuery.size.height * 0.02),
                TextFormFieldCustom(
                    controller: personaCntrl.tlfCntrl,
                    hintText: 'Telefono',
                    obscureText: false),
                SizedBox(height: Get.mediaQuery.size.height * 0.12),
                BtnLoad(
                    onTap: () => personaCntrl.setDataPersona(),
                    btnController: personaCntrl.btnCntlPerson,
                    title: 'Continuar'),
                SizedBox(height: Get.mediaQuery.size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
