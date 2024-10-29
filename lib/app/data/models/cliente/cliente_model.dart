import 'dart:convert';

import 'package:taller/app/data/models/reparacion/reparacion_model.dart';

class ClienteModel {
  String? id;
  String? nif;
  String? nombre;
  String? apellido1;
  String? apellido2;
  String? telefono;
  String? email;
  List<ReparacionModel>? reparaciones;
  DateTime? createdAt;
  DateTime? updatedAt;

  ClienteModel({
    this.id,
    this.nif,
    this.nombre,
    this.apellido1,
    this.apellido2,
    this.telefono,
    this.email,
    this.reparaciones,
    this.createdAt,
    this.updatedAt,
  });

  factory ClienteModel.fromRawJson(String str) =>
      ClienteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
    id: json["id"],
    nif: json["nif"],
    nombre: json["nombre"],
    apellido1: json["apellido1"],
    apellido2: json["apellido2"],
    telefono: json["telefono"],
    email: json["email"],
    reparaciones: List<ReparacionModel>.from(json["reparaciones"].map((x) => ReparacionModel.fromJson(x))),
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
    "reparaciones": reparaciones == null ? [] : List<dynamic>.from(reparaciones!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    String reparacionesStr = reparaciones != null
        ? reparaciones!.map((reparacion) => reparacion.toString()).join(", ")
        : "No reparaciones";

    return 'Cliente{id: $id, nif: $nif, nombre: $nombre, apellido1: $apellido1, apellido2: $apellido2, telefono: $telefono, email: $email, reparaciones: [$reparacionesStr]}';
  }
}