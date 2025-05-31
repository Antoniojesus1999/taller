import 'dart:convert';

import 'package:taller/app/data/models/coches/color_vehiculo.dart';

class Vehiculo {
  String? id;
  String? matricula;
  String? marca;
  String? modelo;
  ColorVehiculo? color;
  String? combustible;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vehiculo({
    this.id,
    this.matricula,
    this.marca,
    this.modelo,
    this.combustible,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehiculo.fromRawJson(String str) =>
      Vehiculo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        id: json["id"],
        matricula: json["matricula"],
        marca: json["marca"],
        modelo: json["modelo"],
        combustible: json["combustible"],
        color: json["color"] != null
            ? ColorVehiculo.fromJson(json["color"])
            : null,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "matricula": matricula,
        "marca": marca,
        "modelo": modelo,
        "combustible": combustible,
        "color": color?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return 'Vehiculo{id: $id, matricula: $matricula, marca: $marca, modelo: $modelo, combustible: $combustible color: $color}';
  }
}
