import 'dart:convert';
import '../../domain/entities/files_entity.dart';

FilesModel filesModelFromJson(String str) => FilesModel.fromJson(json.decode(str));

String filesModelToJson(FilesModel data) => json.encode(data.toJson());

class FilesModel extends FilesEntity {
  FilesModel({
  required  this.index,
  required  this.items,
  }):super(
    index:index,
    items:items
  );

 final int index;
 final List<Item> items;

  factory FilesModel.fromJson(Map<String, dynamic> json) => FilesModel(
    index: json["index"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
  required  this.id,
  required  this.name,
  required  this.path,
    required this.url,
  });

 final int id;
 final String name;
 final String path;
 final String url;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    path: json["path"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "path": path,
    "url": url,
  };
}
