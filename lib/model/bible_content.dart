class BibleVerse {
  final int verseNumber;
  final String content;

  BibleVerse({
    required this.verseNumber,
    required this.content,
  });
}

class BibleChapter {
  final int chapterNumber;
  final String title;
  final List<BibleVerse> verses;
  final String audioUrl;
  final String content;

  BibleChapter({
    required this.chapterNumber,
    required this.title,
    required this.verses,
    required this.audioUrl,
    required this.content,
  });
}

// Mock Data
final mockChapter = BibleChapter(
  chapterNumber: 1,
  title: "The Lord is my shepherd",
  audioUrl: "assets/audio/bible.mp3",
  content:
      "The Lord is my shepherd; shall not want. He makes me lie down in green pastures; He leads me beside still waters. He restores my soul; He guides me in paths of righteousness for His name's sake.",
  verses: [
    BibleVerse(
      verseNumber: 1,
      content:
          "The Lord is my shepherd; shall not want. He makes me lie down in green pastures; He leads me beside still waters. He restores my soul; He guides me in paths of righteousness for His name's sake.",
    ),
    BibleVerse(
      verseNumber: 2,
      content:
          "though I walk through the valley of the shadow of death, I will fear no evil, for You are with me; Your rod and Your staff, they comfort me.",
    ),
    BibleVerse(
      verseNumber: 3,
      content:
          "You prepare a table before me in the presence of my enemies; You anoint my head with oil; my cup overflows.",
    ),
    BibleVerse(
      verseNumber: 4,
      content:
          "though I walk through the valley of the shadow of death, I will fear no evil, for You are with me; Your rod and Your staff, they comfort me.",
    ),
  ],
);
