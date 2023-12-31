// To parse this JSON data, do
//
//     final searchProcessModel = searchProcessModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/search_process_entity.dart';

List<SearchProcessModel> searchProcessModelFromJson(String str) => List<SearchProcessModel>.from(json.decode(str).map((x) => SearchProcessModel.fromJson(x)));

String searchProcessModelToJson(List<SearchProcessModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchProcessModel  extends SearchProcessEntity{
  SearchProcessModel({
   required this.id,
   required this.text,
  }):super(
    id:id,
    text:text
  );

  int id;
  String text;

  factory SearchProcessModel.fromJson(Map<String, dynamic> json) => SearchProcessModel(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
  };
}
