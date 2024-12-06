import 'dart:convert';

SearchChapterModel searchChapterModelFromJson(String str) =>
    SearchChapterModel.fromJson(json.decode(str));

String searchChapterModelToJson(SearchChapterModel data) =>
    json.encode(data.toJson());

class SearchChapterModel {
  Data data;
  Meta meta;

  SearchChapterModel({
    required this.data,
    required this.meta,
  });

  factory SearchChapterModel.fromJson(Map<String, dynamic> json) =>
      SearchChapterModel(
        data: Data.fromJson(json["data"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

class Data {
  String query;
  int limit;
  int offset;
  int total;
  int verseCount;
  List<Verse> verses;

  Data({
    required this.query,
    required this.limit,
    required this.offset,
    required this.total,
    required this.verseCount,
    required this.verses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        query: json["query"],
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
        verseCount: json["verseCount"],
        verses: List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": query,
        "limit": limit,
        "offset": offset,
        "total": total,
        "verseCount": verseCount,
        "verses": List<dynamic>.from(verses.map((x) => x.toJson())),
      };
}

class Verse {
  String id;
  String orgId;
  String bookId;
  String bibleId;
  String chapterId;
  String reference;
  String text;

  Verse({
    required this.id,
    required this.orgId,
    required this.bookId,
    required this.bibleId,
    required this.chapterId,
    required this.reference,
    required this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json["id"],
        orgId: json["orgId"],
        bookId: json["bookId"],
        bibleId: json["bibleId"],
        chapterId: json["chapterId"],
        reference: json["reference"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orgId": orgId,
        "bookId": bookId,
        "bibleId": bibleId,
        "chapterId": chapterId,
        "reference": reference,
        "text": text,
      };
}

class Meta {
  String fums;
  String fumsId;
  String fumsJsInclude;
  String fumsJs;
  String fumsNoScript;

  Meta({
    required this.fums,
    required this.fumsId,
    required this.fumsJsInclude,
    required this.fumsJs,
    required this.fumsNoScript,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        fums: json["fums"],
        fumsId: json["fumsId"],
        fumsJsInclude: json["fumsJsInclude"],
        fumsJs: json["fumsJs"],
        fumsNoScript: json["fumsNoScript"],
      );

  Map<String, dynamic> toJson() => {
        "fums": fums,
        "fumsId": fumsId,
        "fumsJsInclude": fumsJsInclude,
        "fumsJs": fumsJs,
        "fumsNoScript": fumsNoScript,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
