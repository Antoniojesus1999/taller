// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:taller/app/utils/temscript/model.dart';


List<Brand> brandFromJson(String str) =>
    List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));

String brandToJson(List<Brand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Brand {
  int id;
  String name;
  String slug;
  List<Model> models;

  Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.models,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
  final List<dynamic>? modelsData = json['models'];
  List<Model> modelsList = [];

  if (modelsData != null) {
    modelsList = modelsData.map((modelJson) => Model.fromJson(modelJson)).toList();
  }

  return Brand(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    models: modelsList,
  );
}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'models': models.map((model) => model.toMap()).toList(),
    };
  }
  static List<Brand> fromFirebase(List<Map<String, dynamic>> firebaseData) {
    return firebaseData.map((data) => Brand.fromJson(data)).toList();
  }
}
