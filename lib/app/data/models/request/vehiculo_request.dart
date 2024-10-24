import 'dart:convert';

class VehiculoRequest {
  String matricula;
  String marca;
  String modelo;

  VehiculoRequest({
    required this.matricula,
    required this.marca,
    required this.modelo,
  });

  factory VehiculoRequest.fromRawJson(String str) =>
      VehiculoRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehiculoRequest.fromJson(Map<String, dynamic> json) =>
      VehiculoRequest(
        matricula: json["matricula"],
        marca: json["marca"],
        modelo: json["modelo"],
      );

  Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "marca": marca,
        "modelo": modelo,
      };

 @override
 String toString() {
  return 'VehiculoRequest { matricula: $matricula, marca: $marca, modelo: $modelo}';
}
}
