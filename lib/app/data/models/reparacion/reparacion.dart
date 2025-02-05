import 'dart:convert';

import 'package:taller/app/data/models/cliente/cliente.dart';
import 'package:taller/app/data/models/taller/taller.dart';

import '../vehiculo/vehiculo.dart';

class Reparacion {
    String? id;
    DateTime? fecEntrada;
    String? combustible;
    String? kilometros;
    String? seguro;
    String? chasis;
    List<Trabajo>? trabajos;
    List<Danyo>? danyos;
    Taller? taller;
    Cliente? cliente;
    Vehiculo? vehiculo;

    Reparacion({
        this.id,
        this.fecEntrada,
        this.combustible,
        this.kilometros,
        this.seguro,
        this.chasis,
        this.trabajos,
        this.danyos,
        this.taller,
        this.cliente,
        this.vehiculo,
    });

    factory Reparacion.fromRawJson(String str) => Reparacion.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Reparacion.fromJson(Map<String, dynamic> json) => Reparacion(
        id:json["id"],
        fecEntrada: json["fecEntrada"] == null ? null : DateTime.parse(json["fecEntrada"]),
        combustible: json["combustible"],
        kilometros: json["kilometros"],
        seguro: json["seguro"],
        chasis: json["chasis"],
        trabajos: List<Trabajo>.from(json["trabajos"].map((x) => Trabajo.fromJson(x))),
        danyos: List<Danyo>.from(json["danyos"].map((x) => Danyo.fromJson(x))),
        taller: Taller.fromJson(json["taller"]),
        cliente: Cliente.fromJson(json["cliente"]),
        vehiculo: Vehiculo.fromJson(json["vehiculo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecEntrada": fecEntrada?.toIso8601String(),
        "combustible": combustible,
        "kilometros": kilometros,
        "seguro": seguro,
        "chasis": chasis,
        "trabajos": trabajos == null ? [] : List<dynamic>.from(trabajos!.map((x) => x.toJson())),
        "danyos": danyos == null ? [] : List<dynamic>.from(danyos!.map((x) => x.toJson())),
        "taller": taller?.id,
        "cliente": cliente?.id,
        "vehiculo": vehiculo?.id,
    };
  
    @override
    String toString() {
      return 'Reparacion{id: $id, $fecEntrada: $fecEntrada, combustible: $combustible, kilometros: $kilometros, seguro: $seguro, chasis: $chasis, trabajos: $trabajos, danyos: $danyos, taller: $taller, cliente: $cliente, vehiculo: $vehiculo}';
   }
}

class Danyo {
    double positionX;
    double positionY;
    double origWidth;
    double origHeight;

    Danyo({
        required this.positionX,
        required this.positionY,
        required this.origWidth,
        required this.origHeight,
    });

    factory Danyo.fromRawJson(String str) => Danyo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Danyo.fromJson(Map<String, dynamic> json) => Danyo(
        positionX: double.parse(json["positionX"] as String),
        positionY: double.parse(json["positionY"] as String),
        origWidth: double.parse(json["origWidth"] as String),
        origHeight: double.parse(json["origHeight"] as String),
    );

    Map<String, dynamic> toJson() => {
        "positionX": positionX,
        "positionY": positionY,
        "origWidth": origWidth,
        "origHeight": origHeight,
    };

    @override
    String toString() {
    return 'Danyo{positionX: $positionX, positionY: $positionY, origWidth: $origWidth, origHeight: $origHeight}';
  }
}

class Trabajo {
    final String descripcion;

    Trabajo({
        required this.descripcion,
    });

    factory Trabajo.fromRawJson(String str) => Trabajo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Trabajo.fromJson(Map<String, dynamic> json) => Trabajo(
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
    };
    @override
    String toString() {
    return 'Trabajo{descripcion: $descripcion}';
  }
}