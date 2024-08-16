import 'dart:convert';

List<ClassModel> classModelFromJson(String str) =>
    List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));

String classModelToJson(List<ClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
  final int id;
  final String title;

  ClassModel({
    required this.id,
    required this.title,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json["id"],
        title: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": title,
      };
}
