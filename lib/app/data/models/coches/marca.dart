import 'dart:convert';

class Marca {
  String id;
  String nombre;
  String slug;
  List<Modelo> modelos;
  DateTime? createdAt;
  DateTime? updatedAt;

  Marca({
    required this.id,
    required this.nombre,
    required this.slug,
    required this.modelos,
    this.createdAt,
    this.updatedAt,
  });

  factory Marca.fromRawJson(String str) => Marca.fromJson(json.decode(str));

  String toRawJson(List<Marca> brands) => json.encode(toJson());

  factory Marca.fromJson(Map<String, dynamic> json) => Marca(
        id: json["id"],
        nombre: json["nombre"],
        slug: json["slug"],
        modelos:
            List<Modelo>.from(json["modelos"].map((x) => Modelo.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "slug": slug,
        "modelos": List<Modelo>.from(modelos.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Modelo {
  String nombre;
  String slug;

  Modelo({
    required this.nombre,
    required this.slug,
  });

  factory Modelo.fromRawJson(String str) => Modelo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Modelo.fromJson(Map<String, dynamic> json) => Modelo(
        nombre: json["nombre"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "slug": slug,
      };
}
