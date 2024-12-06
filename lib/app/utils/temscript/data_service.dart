import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:taller/app/utils/temscript/Brand.dart';


class DataService extends GetxService {
  static List<Brand> listBrand = [];

  static Future<List<Brand>> getBrandFirebase(String nameCollection) async {
    Logger log = Logger();
    try {
      await FirebaseFirestore.instance
          .collection(nameCollection)
          .get()
          .then((snapshot) {
        final List<Map<String, dynamic>> firebaseData =
            snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
        final List<Brand> brands = Brand.fromFirebase(firebaseData);
        listBrand = brands;
        log.i('Se a obtenido con exito las marcas y modelos');
      });
    } catch (e) {
      log.f('Error al obtener las marcas');
      throw Exception('Error al obtener las marcas');
    }

    return listBrand;
  }
}