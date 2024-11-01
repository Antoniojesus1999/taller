import 'dart:convert';

class Vehiculo {
  String? id;
  String? matricula;
  String? marca;
  String? modelo;
  List<dynamic>? reparaciones;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vehiculo({
    this.id,
    this.matricula,
    this.marca,
    this.modelo,
    this.reparaciones,
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
        reparaciones: json["reparaciones"] == null
            ? []
            : List<dynamic>.from(json["reparaciones"]!.map((x) => x)),
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
        "reparaciones": reparaciones == null
            ? []
            : List<dynamic>.from(reparaciones!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return 'Vehiculo{id: $id, matricula: $matricula, marca: $marca, modelo: $modelo, reparaciones: $reparaciones, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
