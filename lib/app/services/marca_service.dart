import 'package:taller/app/repositories/marcas_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../data/models/coches/marca.dart';

class MarcaService extends GetxService {
  List<Marca> listBrand = [];
  List<String> listNameBrand = [];
  List<Modelo> listModel = <Modelo>[];
  List<String> listNameModel = [];
  Logger log = Logger();
  final MarcasRepository marcasRepository;

  MarcaService({required this.marcasRepository});

  final Marca brandNotFound = Marca(
      id: '1',
      nombre: 'no encontrado',
      slug: 'no encontrado',
      modelos: [Modelo(nombre: 'no encontrado', slug: 'no encontrado')]);

  Future<void> getBrand() async {
    await marcasRepository.getMarcas().then((value) {
      listBrand = value;
      listNameBrand = listBrand.map((e) => e.nombre).toList();
      listModel = listBrand.expand((element) => element.modelos).toList();
      listNameModel = listModel.map((e) => e.nombre).toList();
    });
  }

  String findBrandByName(String nameBrand) {
    return listBrand
        .firstWhere((brand) => brand.nombre == nameBrand,
            orElse: () => brandNotFound)
        .id;
  }

  String findMarcaByNombreModelo(String nombreModelo) {
    try {
      final marca = listBrand.firstWhere((marca) =>
          marca.modelos.any((modelo) => modelo.nombre == nombreModelo));
      return marca.nombre;
    } catch (e) {
      throw Exception('No se ha encontrado el modelo $nombreModelo');
    }
  }
}
