// To parse this JSON data, do
//
//     final chapterViewModel = chapterViewModelFromJson(jsonString);

import 'dart:convert';

ChapterViewModel chapterViewModelFromJson(String str) =>
    ChapterViewModel.fromJson(json.decode(str));

String chapterViewModelToJson(ChapterViewModel data) =>
    json.encode(data.toJson());

class ChapterViewModel {
  Data data;
  Meta meta;

  ChapterViewModel({
    required this.data,
    required this.meta,
  });

  factory ChapterViewModel.fromJson(Map<String, dynamic> json) =>
      ChapterViewModel(
        data: Data.fromJson(json["data"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

class Data {
  String id;
  String bibleId;
  String number;
  String bookId;
  String reference;
  String copyright;
  int verseCount;
  String content;
  Next next;
  Next previous;

  Data({
    required this.id,
    required this.bibleId,
    required this.number,
    required this.bookId,
    required this.reference,
    required this.copyright,
    required this.verseCount,
    required this.content,
    required this.next,
    required this.previous,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        bibleId: json["bibleId"],
        number: json["number"],
        bookId: json["bookId"],
        reference: json["reference"],
        copyright: json["copyright"],
        verseCount: json["verseCount"],
        content: json["content"],
        next: Next.fromJson(json["next"]),
        previous: Next.fromJson(json["previous"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bibleId": bibleId,
        "number": number,
        "bookId": bookId,
        "reference": reference,
        "copyright": copyright,
        "verseCount": verseCount,
        "content": content,
        "next": next.toJson(),
        "previous": previous.toJson(),
      };
}

class Next {
  String id;
  String number;
  String bookId;

  Next({
    required this.id,
    required this.number,
    required this.bookId,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        id: json["id"],
        number: json["number"],
        bookId: json["bookId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "bookId": bookId,
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
