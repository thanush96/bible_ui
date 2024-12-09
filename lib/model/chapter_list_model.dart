import 'dart:convert';

ChapterListDataViewModel chapterListViewModelFromJson(String str) =>
    ChapterListDataViewModel.fromJson(json.decode(str));

String chapterListViewModelToJson(ChapterListDataViewModel data) =>
    json.encode(data.toJson());

class ChapterListDataViewModel {
  List<ChapterData> data;

  ChapterListDataViewModel({
    required this.data,
  });

  factory ChapterListDataViewModel.fromJson(Map<String, dynamic> json) =>
      ChapterListDataViewModel(
        data: List<ChapterData>.from(
            json["data"].map((x) => ChapterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ChapterData {
  String id;
  // String bibleId;
  String bookId;
  String number;
  // String reference;

  ChapterData({
    required this.id,
    // required this.bibleId,
    required this.bookId,
    required this.number,
    // required this.reference,
  });

  factory ChapterData.fromJson(Map<String, dynamic> json) => ChapterData(
        id: json["id"],
        // bibleId: json["bibleId"],
        bookId: json["bookId"],
        number: json["number"],
        // reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "bibleId": bibleId,
        "bookId": bookId,
        "number": number,
        // "reference": reference,
      };
}
