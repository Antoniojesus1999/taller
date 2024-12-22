import 'dart:convert';

class ColorVehiculo {
  String? id;
  String? nombre;
  String? colorR;
  String? colorG;
  String? colorB;
  DateTime? createdAt;
  DateTime? updatedAt;

  ColorVehiculo({
    this.id,
    this.nombre,
    this.colorR,
    this.colorG,
    this.colorB ,
    this.createdAt,
    this.updatedAt,
  });

  factory ColorVehiculo.fromRawJson(String str) => ColorVehiculo.fromJson(json.decode(str));

  String toRawJson(List<ColorVehiculo> brands) => json.encode(toJson());

  factory ColorVehiculo.fromJson(Map<String, dynamic> json) => ColorVehiculo(
        id: json["id"],
        nombre: json["nombre"],
        colorR: json["colorR"],
        colorG: json["colorG"],
        colorB: json["colorB"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "colorR": colorR,
        "colorG": colorG,
        "colorB": colorB,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}