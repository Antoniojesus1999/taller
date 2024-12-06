import 'dart:convert';

List<Model> modelFromJson(String str) =>
    List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Model {
  int idMarca;
  int id;
  String name;
  dynamic slug;

  Model({
    required this.idMarca,
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        idMarca: json["id_marca"],
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id_marca': idMarca,
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}
