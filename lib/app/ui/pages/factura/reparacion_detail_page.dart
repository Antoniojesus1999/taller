import 'package:taller/app/controllers/invoice/reparacion_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReparacionDetailPage extends GetView<ReparacionDetailController> {
  const ReparacionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GroupWidget(
                    title: 'Datos del cliente',
                    details: {
                      '${controller.reparacion.cliente!.nombre} ${controller.reparacion.cliente!.apellido1} ${controller.reparacion.cliente!.apellido2}':
                          controller.reparacion.cliente!.nif!,
                      controller.reparacion.cliente!.email!: '',
                    },
                  ),
                  const SizedBox(height: 20),
                  GroupWidget(
                    title: 'Datos del vehiculo',
                    details: {
                      //TODO: Al mostrar la matricula si en bd hay una lista de coches que conches mostramos? estoy mostrando el 1 por ahora
                      'Matricula:': controller.reparacion.vehiculo!.matricula!,
                      'Modelo:': controller.reparacion.vehiculo!.modelo!,
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: Colors.lightBlue,
                    height: 300,
                  ),
                  const SizedBox(height: 20),
                  const GroupWidget(
                    title: '',
                    details: {
                      'Descripción larga de lo que le sucede al coche escrita por el trabajador este mensaje puede ser un poco largo tenemos que ver si cambiar el widget para hacer uno especifico':
                          '',
                    },
                  ),
                ])),
      ),
    );
  }
}

class GroupWidget extends StatelessWidget {
  final String title;
  final Map<String, String> details;

  const GroupWidget({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15),
          child: title != ''
              ? Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(135, 164, 164, 164),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: details.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    entry.key != ''
                        ? Expanded(
                            child: Text(
                            entry.key,
                          ))
                        : const SizedBox.shrink(),
                    Text(entry.value)
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
