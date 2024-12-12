// To parse this JSON data, do
//
//     final chapterVersesModel = chapterVersesModelFromJson(jsonString);

import 'dart:convert';

ChapterVersesModel chapterVersesModelFromJson(String str) =>
    ChapterVersesModel.fromJson(json.decode(str));

String chapterVersesModelToJson(ChapterVersesModel data) =>
    json.encode(data.toJson());

class ChapterVersesModel {
  List<ChapterVersesData> data;

  ChapterVersesModel({
    required this.data,
  });

  factory ChapterVersesModel.fromJson(Map<String, dynamic> json) =>
      ChapterVersesModel(
        data: List<ChapterVersesData>.from(
            json["data"].map((x) => ChapterVersesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ChapterVersesData {
  String id;
  String orgId;
  String bookId;
  String chapterId;
  String bibleId;
  String reference;

  ChapterVersesData({
    required this.id,
    required this.orgId,
    required this.bookId,
    required this.chapterId,
    required this.bibleId,
    required this.reference,
  });

  factory ChapterVersesData.fromJson(Map<String, dynamic> json) =>
      ChapterVersesData(
        id: json["id"],
        orgId: json["orgId"],
        bookId: json["bookId"],
        chapterId: json["chapterId"],
        bibleId: json["bibleId"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orgId": orgId,
        "bookId": bookId,
        "chapterId": chapterId,
        "bibleId": bibleId,
        "reference": reference,
      };
}
