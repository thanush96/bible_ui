// To parse this JSON data, do
//
//     final bookDetailModel = bookDetailModelFromJson(jsonString);

import 'dart:convert';

BookDetailModel bookDetailModelFromJson(String str) =>
    BookDetailModel.fromJson(json.decode(str));

String bookDetailModelToJson(BookDetailModel data) =>
    json.encode(data.toJson());

class BookDetailModel {
  Data data;

  BookDetailModel({
    required this.data,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) =>
      BookDetailModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String bibleId;
  String abbreviation;
  String name;
  String nameLong;

  Data({
    required this.id,
    required this.bibleId,
    required this.abbreviation,
    required this.name,
    required this.nameLong,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        bibleId: json["bibleId"],
        abbreviation: json["abbreviation"],
        name: json["name"],
        nameLong: json["nameLong"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bibleId": bibleId,
        "abbreviation": abbreviation,
        "name": name,
        "nameLong": nameLong,
      };
}
