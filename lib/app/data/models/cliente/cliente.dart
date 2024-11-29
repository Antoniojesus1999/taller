import 'dart:convert';

class Cliente {
  String? id;
  String? nif;
  String? nombre;
  String? apellido1;
  String? apellido2;
  String? telefono;
  String? email;
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'Cliente{id: $id, nif: $nif, nombre: $nombre, apellido1: $apellido1, apellido2: $apellido2, telefono: $telefono, email: $email}';
  }
}