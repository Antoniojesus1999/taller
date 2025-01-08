import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taller/app/controllers/home/trabajo_controller.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';
import 'package:taller/app/ui/global_widgets/text_form_field_custom.dart';

class TrabajoPage extends GetView<TrabajoController> {
  const TrabajoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    controller.handleArguments(args);
    return Scaffold(
      appBar: AppBar(title: Text('Trabajos')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lista de trabajos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.trabajos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.trabajos[index]),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        dense: true, // Ajusta el padding interno del ListTile
                        visualDensity: VisualDensity(vertical: -4), // Ajustar la densidad visual

                      );
                    },
                  );
                }),
              ),
              SizedBox(height: 16),
              Form(
                key: controller.formTrabajo,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descripción del Trabajo',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormFieldCustom(
                      controller: controller.descripcionTrabajo,
                      hintText: 'Descripción del trabajo',
                      validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                      maxLines: 5,
                      obscureText: false,
                    ),
                    SizedBox(height: 16),
                    BtnLoad(
                      onTap: () => controller.sendData(),
                      btnController: controller.btnCntlFormTrabajo,
                      title: 'Guardar',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
