import 'package:taller/app/controllers/home/home_controller.dart';
import 'package:taller/app/controllers/reparacion/form_persona_cntrl.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/auto_complete_custom_rgp.dart';
import '../../global_widgets/text_field_custom.dart';

class FormPersonaPage extends StatelessWidget {
  const FormPersonaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FormPersonaCntrl personaCntrl = Get.find<FormPersonaCntrl>();
    personaCntrl.setFormContext(context);
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
                      Obx(() => AutoCompleteCustomRgp(
                        controller: personaCntrl.nifCntrl,
                        focusNode: personaCntrl.nifFocus,
                        layerLink: personaCntrl.nifFieldLink,
                        hintText: 'NIF',
                        textoRx: personaCntrl.textoNifRx,
                        obtenerOpciones: personaCntrl.obtenerOpcionesNif,
                        mostrarSugerencias: personaCntrl.mostrarSugerencias,
                        ocultarSugerencias: personaCntrl.ocultarSugerencias,
                        readonly: personaCntrl.microActivo.value,
                        tieneFocusRx: personaCntrl.tieneFocusNif,
                        suffixIcon: Icon(Icons.search),
                        onClear: personaCntrl.limpiarFormulario,
                        onTap: () => personaCntrl.onTapInputs("nif", personaCntrl.nifCntrl, personaCntrl.textoNifRx, personaCntrl.nifFocus, personaCntrl.tieneFocusNif),
                      )),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      Obx(() => TextFieldCustom(
                        controller: personaCntrl.nameCntrl,
                        hintText: 'Nombre',
                        textoRx: personaCntrl.textoNameRx,
                        focusNode: personaCntrl.nameFocus,
                        readonly: personaCntrl.microActivo.value,
                        tieneFocusRx: personaCntrl.tieneFocusName,
                        onClear: () => personaCntrl.clearInput(personaCntrl.nameCntrl, personaCntrl.textoNameRx, personaCntrl.nameFocus),
                        onChanged: (texto) => personaCntrl.onChangeRestInputs(texto, personaCntrl.nameCntrl, personaCntrl.textoNameRx),
                        onTap: () => personaCntrl.onTapInputs("name", personaCntrl.nameCntrl, personaCntrl.textoNameRx, personaCntrl.nameFocus, personaCntrl.tieneFocusName),
                      )),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      Obx(() => TextFieldCustom(
                        controller: personaCntrl.surName1Cntrl,
                        hintText: 'Primer apellido',
                        textoRx: personaCntrl.textoSurName1Rx,
                        focusNode: personaCntrl.surName1Focus,
                        readonly: personaCntrl.microActivo.value,
                        tieneFocusRx: personaCntrl.tieneFocusSurname1,
                        onClear: () => personaCntrl.clearInput(personaCntrl.surName1Cntrl, personaCntrl.textoSurName1Rx, personaCntrl.surName1Focus),
                        onChanged: (texto) => personaCntrl.onChangeRestInputs(texto, personaCntrl.surName1Cntrl, personaCntrl.textoSurName1Rx),
                        onTap: () => personaCntrl.onTapInputs("surName1", personaCntrl.surName1Cntrl, personaCntrl.textoSurName1Rx, personaCntrl.surName1Focus, personaCntrl.tieneFocusSurname1),
                      )),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      Obx(() => TextFieldCustom(
                        controller: personaCntrl.surName2Cntrl,
                        hintText: 'Segundo apellido',
                        textoRx: personaCntrl.textoSurName2Rx,
                        focusNode: personaCntrl.surName2Focus,
                        readonly: personaCntrl.microActivo.value,
                        tieneFocusRx: personaCntrl.tieneFocusSurname2,
                        onClear: () => personaCntrl.clearInput(personaCntrl.surName2Cntrl, personaCntrl.textoSurName2Rx, personaCntrl.surName2Focus),
                        onChanged: (texto) => personaCntrl.onChangeRestInputs(texto, personaCntrl.surName2Cntrl, personaCntrl.textoSurName2Rx),
                        onTap: () => personaCntrl.onTapInputs("surName2", personaCntrl.surName2Cntrl, personaCntrl.textoSurName2Rx, personaCntrl.surName2Focus, personaCntrl.tieneFocusSurname2),
                      )),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      Obx(() => TextFieldCustom(
                        controller: personaCntrl.emailCntrl,
                        hintText: 'Email',
                        textoRx: personaCntrl.textoEmailRx,
                        focusNode: personaCntrl.emailFocus,
                        readonly: personaCntrl.microActivo.value,
                        tieneFocusRx: personaCntrl.tieneFocusEmail,
                        onClear: () => personaCntrl.clearInput(personaCntrl.emailCntrl, personaCntrl.textoEmailRx, personaCntrl.emailFocus),
                        onChanged: (texto) => personaCntrl.textoEmailRx.value = texto,
                        onTap: () => personaCntrl.onTapInputs("email", personaCntrl.emailCntrl, personaCntrl.textoEmailRx, personaCntrl.emailFocus, personaCntrl.tieneFocusEmail),
                      )),
                      SizedBox(height: Get.mediaQuery.size.height * 0.02),
                      Obx(() => TextFieldCustom(
                        controller: personaCntrl.tlfCntrl,
                        hintText: 'Teléfono',
                        textoRx: personaCntrl.textoTlfRx,
                        focusNode: personaCntrl.tlfFocus,
                        readonly: personaCntrl.microActivo.value,
                        tieneFocusRx: personaCntrl.tieneFocusTlf,
                        onClear: () => personaCntrl.clearInput(personaCntrl.tlfCntrl, personaCntrl.textoTlfRx, personaCntrl.tlfFocus),
                        onChanged: (texto) => personaCntrl.textoTlfRx.value = texto,
                        onTap: () => personaCntrl.onTapInputs("tlf", personaCntrl.tlfCntrl, personaCntrl.textoTlfRx, personaCntrl.tlfFocus, personaCntrl.tieneFocusTlf),
                      )),
                      SizedBox(height: Get.mediaQuery.size.height * 0.05),
                      Obx(() => IconButton(
                        iconSize: 40,
                        icon: Icon(
                          personaCntrl.isListening.value ? Icons.mic : Icons.mic_none,
                          color: personaCntrl.microActivo.value ? Colors.red : Colors.black54,
                        ),
                        onPressed: () {
                          if (personaCntrl.microActivo.value) {
                            FocusScope.of(context).unfocus();
                            personaCntrl.stopListening();
                          } else {
                            personaCntrl.microActivo.value = true;
                          }
                          //personaCntrl.startListening(context);
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
