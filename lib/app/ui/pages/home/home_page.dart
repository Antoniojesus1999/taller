import 'package:taller/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final sizeWidth = Get.mediaQuery.size.width;


    void onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll && controller.hayMas.value) {
        controller.getReparaciones();
      }
    }

    scrollController.addListener(onScroll);

    return Scaffold(
      backgroundColor: Color.fromRGBO(200, 200, 200, 1.0),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.userSignOut();
              Get.offAllNamed(Routes.login);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        child: Obx(() => ListView.builder(
            controller: scrollController,
            itemCount: controller.hayMas.value
                ? controller.reparaciones.length + 1
                : controller.reparaciones.length,
            itemBuilder: (context, index) {
              if (index < controller.reparaciones.length) {
                return Card(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  elevation: 10.0,
                  child: ListTile(
                    tileColor: const Color.fromRGBO(250, 250, 250, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    leading: const Icon(
                        Icons.handyman,
                        size: 25,
                        color: Color.fromRGBO(2, 136, 209, 1.0),
                    ),
                    //titleAlignment: ListTileTitleAlignment.threeLine,
                    title: Row(children: [
                        Text(controller.reparaciones[index].vehiculo!.marca!),
                        SizedBox(width: 5),
                        Text(controller.reparaciones[index].vehiculo!.modelo!),
                        SizedBox(width: 5),
                        Text(controller.reparaciones[index].vehiculo!.matricula!),
                      ],
                    ),
                    subtitle: Text('${controller.reparaciones[index].fecEntrada}'),
                    onTap: () => Get.toNamed(Routes.pageReparacionesDetail,
                        arguments: {
                          'reparacion': controller.reparaciones[index]
                        }),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    /*child: CircularProgressIndicator(
                      color: Colors.black,
                    ),*/
                    child: Text("Empiece por dar de alta una reparación"),
                  ),
                );
              }
            })),
      ),
      floatingActionButton: SizedBox(
        width: sizeWidth / 6,
        height: sizeWidth / 6,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.formPerson),
          backgroundColor: const Color.fromRGBO(2, 136, 209, 1.0),
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: sizeWidth / 10),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
