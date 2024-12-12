import 'package:flutter/material.dart';
import 'book_card.dart';

class BookList extends StatelessWidget {
  final List<Map<String, String>> books = [
    {
      "id": "GEN",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Gen",
      "name": "Genesis",
      "nameLong": "The First Book of Moses, called Genesis",
      "imageUrl": "https://example.com/images/genesis.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests.",
    },
    {
      "id": "EXO",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Exo",
      "name": "Exodus",
      "nameLong": "The Second Book of Moses, called Exodus",
      "imageUrl": "https://example.com/images/exodus.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "LEV",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Lev",
      "name": "Leviticus",
      "nameLong": "The Third Book of Moses, called Leviticus",
      "imageUrl": "https://example.com/images/leviticus.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "NUM",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Num",
      "name": "Numbers",
      "nameLong": "The Fourth Book of Moses, called Numbers",
      "imageUrl": "https://example.com/images/numbers.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "DEU",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Deu",
      "name": "Deuteronomy",
      "nameLong": "The Fifth Book of Moses, called Deuteronomy",
      "imageUrl": "https://example.com/images/deuteronomy.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JOS",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Jos",
      "name": "Joshua",
      "nameLong": "The Book of Joshua",
      "imageUrl": "https://example.com/images/joshua.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JDG",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Jdg",
      "name": "Judges",
      "nameLong": "The Book of Judges",
      "imageUrl": "https://example.com/images/judges.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "RUT",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Rut",
      "name": "Ruth",
      "nameLong": "The Book of Ruth",
      "imageUrl": "https://example.com/images/ruth.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1SA",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Sa",
      "name": "1 Samuel",
      "nameLong":
          "The First Book of Samuel Otherwise Called The First Book of the Kings",
      "imageUrl": "https://example.com/images/1samuel.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "2SA",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "2Sa",
      "name": "2 Samuel",
      "nameLong":
          "The Second Book of Samuel Otherwise Called The Second Book of the Kings",
      "imageUrl": "https://example.com/images/2samuel.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1KI",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Ki",
      "name": "1 Kings",
      "nameLong":
          "The First Book of the Kings, Commonly Called the Third Book of the Kings",
      "imageUrl": "https://example.com/images/1kings.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "2KI",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "2Ki",
      "name": "2 Kings",
      "nameLong":
          "The Second Book of the Kings, Commonly Called the Fourth Book of the Kings",
      "imageUrl": "https://example.com/images/2kings.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1CH",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Ch",
      "name": "1 Chronicles",
      "nameLong": "The First Book of the Chronicles",
      "imageUrl": "https://example.com/images/1chronicles.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "2CH",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "2Ch",
      "name": "2 Chronicles",
      "nameLong": "The Second Book of the Chronicles",
      "imageUrl": "https://example.com/images/2chronicles.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "EZR",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Ezr",
      "name": "Ezra",
      "nameLong": "Ezra",
      "imageUrl": "https://example.com/images/ezra.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "NEH",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Neh",
      "name": "Nehemiah",
      "nameLong": "The Book of Nehemiah",
      "imageUrl": "https://example.com/images/nehemiah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "EST",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Est",
      "name": "Esther",
      "nameLong": "The Book of Esther",
      "imageUrl": "https://example.com/images/esther.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JOB",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Job",
      "name": "Job",
      "nameLong": "The Book of Job",
      "imageUrl": "https://example.com/images/job.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "PSA",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Psa",
      "name": "Psalms",
      "nameLong": "The Book of Psalms",
      "imageUrl": "https://example.com/images/psalms.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "PRO",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Pro",
      "name": "Proverbs",
      "nameLong": "The Proverbs",
      "imageUrl": "https://example.com/images/proverbs.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "ECC",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Ecc",
      "name": "Ecclesiastes",
      "nameLong": "Ecclesiastes or, the Preacher",
      "imageUrl": "https://example.com/images/ecclesiastes.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "SNG",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Sng",
      "name": "Song of Solomon",
      "nameLong": "The Song of Solomon",
      "imageUrl": "https://example.com/images/songofsolomon.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "ISA",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Isa",
      "name": "Isaiah",
      "nameLong": "The Book of the Prophet Isaiah",
      "imageUrl": "https://example.com/images/isaiah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JER",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Jer",
      "name": "Jeremiah",
      "nameLong": "The Book of the Prophet Jeremiah",
      "imageUrl": "https://example.com/images/jeremiah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "LAM",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Lam",
      "name": "Lamentations",
      "nameLong": "The Lamentations of Jeremiah",
      "imageUrl": "https://example.com/images/lamentations.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "EZK",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Ezk",
      "name": "Ezekiel",
      "nameLong": "The Book of the Prophet Ezekiel",
      "imageUrl": "https://example.com/images/ezekiel.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "DAN",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Dan",
      "name": "Daniel",
      "nameLong": "The Book of Daniel",
      "imageUrl": "https://example.com/images/daniel.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "HOS",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Hos",
      "name": "Hosea",
      "nameLong": "Hosea",
      "imageUrl": "https://example.com/images/hosea.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JOL",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Jol",
      "name": "Joel",
      "nameLong": "Joel",
      "imageUrl": "https://example.com/images/joel.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "AMO",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Amo",
      "name": "Amos",
      "nameLong": "Amos",
      "imageUrl": "https://example.com/images/amos.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "OBA",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Oba",
      "name": "Obadiah",
      "nameLong": "Obadiah",
      "imageUrl": "https://example.com/images/obadiah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JON",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Jon",
      "name": "Jonah",
      "nameLong": "Jonah",
      "imageUrl": "https://example.com/images/jonah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "MIC",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Mic",
      "name": "Micah",
      "nameLong": "Micah",
      "imageUrl": "https://example.com/images/micah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "NAM",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Nam",
      "name": "Nahum",
      "nameLong": "Nahum",
      "imageUrl": "https://example.com/images/nahum.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "HAB",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Hab",
      "name": "Habakkuk",
      "nameLong": "Habakkuk",
      "imageUrl": "https://example.com/images/habakkuk.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "ZEP",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Zep",
      "name": "Zephaniah",
      "nameLong": "Zephaniah",
      "imageUrl": "https://example.com/images/zephaniah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "HAG",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Hag",
      "name": "Haggai",
      "nameLong": "Haggai",
      "imageUrl": "https://example.com/images/haggai.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "ZEC",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Zec",
      "name": "Zechariah",
      "nameLong": "Zechariah",
      "imageUrl": "https://example.com/images/zechariah.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "MAL",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Mal",
      "name": "Malachi",
      "nameLong": "Malachi",
      "imageUrl": "https://example.com/images/malachi.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "MAT",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Mat",
      "name": "Matthew",
      "nameLong": "The Gospel According to Matthew",
      "imageUrl": "https://example.com/images/matthew.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "MRK",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Mrk",
      "name": "Mark",
      "nameLong": "The Gospel According to Mark",
      "imageUrl": "https://example.com/images/mark.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "LUK",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Luk",
      "name": "Luke",
      "nameLong": "The Gospel According to Luke",
      "imageUrl": "https://example.com/images/luke.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JHN",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Jhn",
      "name": "John",
      "nameLong": "The Gospel According to John",
      "imageUrl": "https://example.com/images/john.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "ACT",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Act",
      "name": "Acts",
      "nameLong": "The Acts of the Apostles",
      "imageUrl": "https://example.com/images/acts.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "ROM",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Rom",
      "name": "Romans",
      "nameLong": "The Epistle of Paul the Apostle to the Romans",
      "imageUrl": "https://example.com/images/romans.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1CO",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Co",
      "name": "1 Corinthians",
      "nameLong": "The First Epistle of Paul the Apostle to the Corinthians",
      "imageUrl": "https://example.com/images/1corinthians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "2CO",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "2Co",
      "name": "2 Corinthians",
      "nameLong": "The Second Epistle of Paul the Apostle to the Corinthians",
      "imageUrl": "https://example.com/images/2corinthians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "GAL",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Gal",
      "name": "Galatians",
      "nameLong": "The Epistle of Paul the Apostle to the Galatians",
      "imageUrl": "https://example.com/images/galatians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "EPH",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Eph",
      "name": "Ephesians",
      "nameLong": "The Epistle of Paul the Apostle to the Ephesians",
      "imageUrl": "https://example.com/images/ephesians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "PHP",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Php",
      "name": "Philippians",
      "nameLong": "The Epistle of Paul the Apostle to the Philippians",
      "imageUrl": "https://example.com/images/philippians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "COL",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Col",
      "name": "Colossians",
      "nameLong": "The Epistle of Paul the Apostle to the Colossians",
      "imageUrl": "https://example.com/images/colossians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1TH",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Th",
      "name": "1 Thessalonians",
      "nameLong": "The First Epistle of Paul the Apostle to the Thessalonians",
      "imageUrl": "https://example.com/images/1thessalonians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "2TH",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "2Th",
      "name": "2 Thessalonians",
      "nameLong": "The Second Epistle of Paul the Apostle to the Thessalonians",
      "imageUrl": "https://example.com/images/2thessalonians.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1TI",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Ti",
      "name": "1 Timothy",
      "nameLong": "The First Epistle of Paul the Apostle to Timothy",
      "imageUrl": "https://example.com/images/1timothy.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "2TI",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "2Ti",
      "name": "2 Timothy",
      "nameLong": "The Second Epistle of Paul the Apostle to Timothy",
      "imageUrl": "https://example.com/images/2timothy.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "TIT",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Tit",
      "name": "Titus",
      "nameLong": "The Epistle of Paul the Apostle to Titus",
      "imageUrl": "https://example.com/images/titus.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "PHM",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Phm",
      "name": "Philemon",
      "nameLong": "The Epistle of Paul the Apostle to Philemon",
      "imageUrl": "https://example.com/images/philemon.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "HEB",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Heb",
      "name": "Hebrews",
      "nameLong": "The Epistle of Paul the Apostle to the Hebrews",
      "imageUrl": "https://example.com/images/hebrews.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JAM",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Jam",
      "name": "James",
      "nameLong": "The Epistle of James",
      "imageUrl": "https://example.com/images/james.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1PE",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Pe",
      "name": "1 Peter",
      "nameLong": "The First Epistle of Peter",
      "imageUrl": "https://example.com/images/1peter.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "2PE",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "2Pe",
      "name": "2 Peter",
      "nameLong": "The Second Epistle of Peter",
      "imageUrl": "https://example.com/images/2peter.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "1JN",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "1Jn",
      "name": "1 John",
      "nameLong": "The First Epistle of John",
      "imageUrl": "https://example.com/images/1john.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "JUD",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "jud",
      "name": "Jud",
      "nameLong": "THE GENERAL EPISTLE OF JUDE",
      "imageUrl": "https://example.com/images/2john.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
    {
      "id": "REV",
      "bibleId": "de4e12af7f28f599-01",
      "abbreviation": "Rev",
      "name": "Revelation",
      "nameLong": "THE REVELATION OF ST. JOHN THE DIVINE",
      "imageUrl": "https://example.com/images/2john.jpg",
      "summary":
          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests."
    },
  ];

  BookList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270, // Prov"id"e a fixed height for the horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            title: book['name']!,
            id: book['id']!,
            subTitle: book['nameLong']!,
            imageUrl: book['imageUrl']!,
            abbreviation: book['abbreviation']!,
            bibleId: book['bibleId']!,
            summary: book['summary']!,
          );
        },
      ),
    );
  }
}
