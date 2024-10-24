import 'package:taller/app/data/models/taller/inventario/pieza.dart';

class Proveedor {
  String nombre;
  String tlfn;
  String fax;
  List<Pieza> piezas;
  Proveedor({
    required this.nombre,
    required this.tlfn,
    required this.fax,
    required this.piezas,
  });
}
