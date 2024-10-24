import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Usado en el menu
class CardButton extends StatelessWidget {
  final String action;
  final String route;

  const CardButton({super.key, required this.action, required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      child: SizedBox(
        width: 180,
        height: 180,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 4.0,
          color: const Color.fromARGB(255, 0, 255, 221),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(action),
            ),
          ),
        ),
      ),
    );
  }
}
