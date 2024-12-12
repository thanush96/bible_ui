// To parse this JSON data, do
//
//     final versesContentModal = versesContentModalFromJson(jsonString);

import 'dart:convert';

VersesContentModal versesContentModalFromJson(String str) =>
    VersesContentModal.fromJson(json.decode(str));

String versesContentModalToJson(VersesContentModal data) =>
    json.encode(data.toJson());

class VersesContentModal {
  Data data;

  VersesContentModal({
    required this.data,
  });

  factory VersesContentModal.fromJson(Map<String, dynamic> json) =>
      VersesContentModal(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String orgId;
  String bookId;
  String chapterId;
  String bibleId;
  String reference;
  String content;
  int verseCount;
  String copyright;
  Next? next;
  Next? previous;

  Data({
    required this.id,
    required this.orgId,
    required this.bookId,
    required this.chapterId,
    required this.bibleId,
    required this.reference,
    required this.content,
    required this.verseCount,
    required this.copyright,
    this.next,
    this.previous,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        orgId: json["orgId"],
        bookId: json["bookId"],
        chapterId: json["chapterId"],
        bibleId: json["bibleId"],
        reference: json["reference"],
        content: json["content"],
        next: json["next"] != null && json["next"].isNotEmpty
            ? Next.fromJson(json["next"])
            : null,
        verseCount: json["verseCount"],
        copyright: json["copyright"],
        previous: json["previous"] != null && json["previous"].isNotEmpty
            ? Next.fromJson(json["previous"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orgId": orgId,
        "bookId": bookId,
        "chapterId": chapterId,
        "bibleId": bibleId,
        "reference": reference,
        "content": content,
        "verseCount": verseCount,
        "copyright": copyright,
        "next": next?.toJson(),
        "previous": previous?.toJson(),
      };
}

class Next {
  String id;
  String number;

  Next({
    required this.id,
    required this.number,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        id: json["id"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
      };
}
