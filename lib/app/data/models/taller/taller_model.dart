import 'dart:convert';

List<Taller> tallerModelFromJson(String str) => List<Taller>.from(json.decode(str).map((x) => Taller.fromJson(x)));

String tallerModelToJson(List<Taller> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Taller {
    String id;
    String cif;
    String nombre;
    String direccion;
    String cp;
    String municipio;
    String provincia;
    String riia;
    String telefono;
    String fax;
    String email;
    List<dynamic> empleados;
    List<dynamic> reparaciones;
    DateTime createdAt;
    DateTime updatedAt;

    Taller({
        required this.id,
        required this.cif,
        required this.nombre,
        required this.direccion,
        required this.cp,
        required this.municipio,
        required this.provincia,
        required this.riia,
        required this.telefono,
        required this.fax,
        required this.email,
        required this.empleados,
        required this.reparaciones,
        required this.createdAt,
        required this.updatedAt,
    });

    Taller copyWith({
        String? id,
        String? cif,
        String? nombre,
        String? direccion,
        String? cp,
        String? municipio,
        String? provincia,
        String? riia,
        String? telefono,
        String? fax,
        String? email,
        List<dynamic>? empleados,
        List<dynamic>? reparaciones,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Taller(
            id: id ?? this.id,
            cif: cif ?? this.cif,
            nombre: nombre ?? this.nombre,
            direccion: direccion ?? this.direccion,
            cp: cp ?? this.cp,
            municipio: municipio ?? this.municipio,
            provincia: provincia ?? this.provincia,
            riia: riia ?? this.riia,
            telefono: telefono ?? this.telefono,
            fax: fax ?? this.fax,
            email: email ?? this.email,
            empleados: empleados ?? this.empleados,
            reparaciones: reparaciones ?? this.reparaciones,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Taller.fromJson(Map<String, dynamic> json) => Taller(
        id: json["id"],
        cif: json["cif"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        cp: json["cp"],
        municipio: json["municipio"],
        provincia: json["provincia"],
        riia: json["riia"],
        telefono: json["telefono"],
        fax: json["fax"],
        email: json["email"],
        empleados: List<dynamic>.from(json["empleados"].map((x) => x)),
        reparaciones: List<dynamic>.from(json["reparaciones"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cif": cif,
        "nombre": nombre,
        "direccion": direccion,
        "cp": cp,
        "municipio": municipio,
        "provincia": provincia,
        "riia": riia,
        "telefono": telefono,
        "fax": fax,
        "email": email,
        "empleados": List<dynamic>.from(empleados.map((x) => x)),
        "reparaciones": List<dynamic>.from(reparaciones.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
