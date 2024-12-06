import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taller/app/data/models/coches/marca.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:taller/app/utils/temscript/Brand.dart';

class MarcasRepository extends GetConnect {
  final String _urlHost = dotenv.env['URL_HOST_BACK']!;
  final String _getAllMarcas = dotenv.env['URL_FIND_ALL_MARCAS']!;
  final Logger log = Logger();

  static List<Brand> listBrand = [];

  Future<List<Marca>> getMarcas() async {
    getBrandFirebase('brands').then((listBrand) async {

        final response = await post(
        'http://192.168.1.105:3000/marcas/cargar-marcas-modelo',
        brandToJson(listBrand),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // La petición fue exitosa
        print('Petición POST exitosa');
      } else {
        // La petición falló
        print('Error en la petición POST: ${response.statusCode}');
      }
    });
    /*String url = "$_urlHost$_getAllMarcas"
        .replaceAll('{page}', 0.toString())
        .replaceAll('&limit={limit}', '');
    log.i('Se va a obtener todas las marcas url -> $url');
    final rsp = await get(url);
    if (rsp.status.hasError) {
      log.e('Error al obtener las marcas: ${rsp.statusText}');
      throw Exception('Error al obtener las marcas');
    }
    final data = rsp.body;
    var result = List<Marca>.from(data.map((e) => Marca.fromJson(e)));
    return result;*/
    return [];
  }

  Future<List<Brand>> getBrandFirebase(String nameCollection) async {
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
