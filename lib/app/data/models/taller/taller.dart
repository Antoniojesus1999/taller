import 'package:taller/app/data/models/taller/empleado.dart';

class Taller {
    String? id;
    String? cif;
    String? nombre;
    String? direccion;
    String? cp;
    String? municipio;
    String? provincia;
    String? riia;
    String? telefono;
    String? fax;
    String? email;
    List<Empleado>? empleados;
    DateTime? createdAt;
    DateTime? updatedAt;

    Taller({
        this.id,
        this.cif,
        this.nombre,
        this.direccion,
        this.cp,
        this.municipio,
        this.provincia,
        this.riia,
        this.telefono,
        this.fax,
        this.email,
        this.empleados,
        this.createdAt,
        this.updatedAt,
    });

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
        empleados: List<Empleado>.from(json["empleados"].map((x) => Empleado.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "empleados": empleados == null ? [] : List<dynamic>.from(empleados!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
