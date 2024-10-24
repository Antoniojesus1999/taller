import 'dart:convert';

Empleado empleadoFromJson(String str) => Empleado.fromJson(json.decode(str));

String empleadoToJson(Empleado data) => json.encode(data.toJson());

class Empleado {
    String? id;
    String email;
    String photoUrl;
    String displayName;
    String provider;
    String uid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Empleado({
        this.id,
        required this.email,
        required this.photoUrl,
        required this.displayName,
        required this.provider,
        required this.uid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    Empleado copyWith({
        String? id,
        String? email,
        String? photoUrl,
        String? displayName,
        String? provider,
        String? uid,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? v,
    }) => 
        Empleado(
            id: id ?? this.id,
            email: email ?? this.email,
            photoUrl: photoUrl ?? this.photoUrl,
            displayName: displayName ?? this.displayName,
            provider: provider ?? this.provider,
            uid: uid ?? this.uid,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            v: v ?? this.v,
        );

    factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
        id: json["_id"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        displayName: json["displayName"],
        provider: json["provider"],
        uid: json["uid"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "photoUrl": photoUrl,
        "displayName": displayName,
        "provider": provider,
        "uid": uid,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}