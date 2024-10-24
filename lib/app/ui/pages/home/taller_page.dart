import 'package:taller/app/controllers/home/taller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TallerPage extends GetView<TallerCntrl> {
  const TallerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Talleres'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => controller.searchText.value = value,
              decoration: InputDecoration(
                hintText: 'Buscar taller',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.blueGrey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.listaFiltradaTalleres.length,
                  itemBuilder: (context, index) {
                    final taller = controller.listaFiltradaTalleres[index];
                    return ListTile(
                      onTap: () => controller.asociandoEmailATaller(taller.id),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taller.nombre,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${taller.municipio}, ${taller.provincia}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
