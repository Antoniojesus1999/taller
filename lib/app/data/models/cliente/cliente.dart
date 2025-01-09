import 'dart:convert';
import 'dart:ui';

import 'package:signature/signature.dart';

class Cliente {
  String? id;
  String? nif;
  String? nombre;
  String? apellido1;
  String? apellido2;
  String? telefono;
  String? email;
  List<Point>? firma;
  String? firmaBase64;
  DateTime? createdAt;
  DateTime? updatedAt;

  Cliente({
    this.id,
    this.nif,
    this.nombre,
    this.apellido1,
    this.apellido2,
    this.telefono,
    this.email,
    this.firma,
    this.firmaBase64,
    this.createdAt,
    this.updatedAt,
  });

  factory Cliente.fromRawJson(String str) =>
      Cliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    id: json["id"],
    nif: json["nif"],
    nombre: json["nombre"],
    apellido1: json["apellido1"],
    apellido2: json["apellido2"],
    telefono: json["telefono"],
    email: json["email"],
    firma: json["firma"] == null
        ? null
        : (json["firma"] as List)
        .map((point) => Point(
          Offset(double.parse(point["dx"] as String), double.parse(point["dy"] as String)),
          (point["type"] == "tap")  ? PointType.tap : PointType.move,
          double.parse(point["pressure"] as String),
        ))
        .toList(),
    firmaBase64: json["firmaBase64"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nif": nif,
    "nombre": nombre,
    "apellido1": apellido1,
    "apellido2": apellido2,
    "telefono": telefono,
    "email": email,
    "firma": firma
        ?.map((point) => {
          "dx": point.offset.dx,
          "dy": point.offset.dy,
          "pressure": point.pressure,
          "type": point.type.name,
        })
        .toList(),
    "firmaBase64": firmaBase64,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'Cliente{id: $id, nif: $nif, nombre: $nombre, apellido1: $apellido1, apellido2: $apellido2, telefono: $telefono, email: $email}';
  }
}