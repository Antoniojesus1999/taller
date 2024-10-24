import 'dart:convert';

class ClienteRequest {
  String? idTaller;
  Cliente? cliente;

  ClienteRequest({
    this.idTaller,
    this.cliente,
  });

  factory ClienteRequest.fromRawJson(String str) =>
      ClienteRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClienteRequest.fromJson(Map<String, dynamic> json) => ClienteRequest(
        idTaller: json["idTaller"],
        cliente: Cliente.fromJson(json["cliente"]),
      );

  Map<String, dynamic> toJson() => {
        "idTaller": idTaller,
        "cliente": cliente?.toJson(),
      };
  @override
  String toString() {
    return 'ClienteRequest{idTaller: $idTaller, cliente: $cliente}';
  }
}

class Cliente {
  String? id;
  String nif;
  String nombre;
  String? apellido1;
  String? apellido2;
  String? telefono;
  String? email;

  Cliente({
    this.id,
    required this.nif,
    required this.nombre,
    this.apellido1,
    this.apellido2,
    this.telefono,
    this.email,
  });

  factory Cliente.fromRawJson(String str) =>
      Cliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        nif: json["nif"],
        nombre: json["nombre"],
        apellido1: json["apellido_1"],
        apellido2: json["apellido_2"],
        telefono: json["telefono"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nif": nif,
        "nombre": nombre,
        "apellido_1": apellido1,
        "apellido_2": apellido2,
        "telefono": telefono,
        "email": email,
      };
      
 @override
  String toString() {
    return 'Cliente{id: $id, nif: $nif, nombre: $nombre, apellido1: $apellido1, apellido2: $apellido2, telefono: $telefono, email: $email}';
  }
}
