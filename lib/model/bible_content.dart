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
final List<BibleChapter> mockChapters = [
  BibleChapter(
    chapterNumber: 1,
    title: "The Lord is my shepherd",
    audioUrl: "assets/audio/chapter1.mp3",
    content:
        "The Lord is my shepherd; I shall not want. He makes me lie down in green pastures; He leads me beside still waters. He restores my soul; He guides me in paths of righteousness for His name's sake.",
    verses: [
      BibleVerse(
          verseNumber: 1,
          content: "The Lord is my shepherd; I shall not want."),
      BibleVerse(
          verseNumber: 2, content: "He makes me lie down in green pastures."),
      BibleVerse(verseNumber: 3, content: "He leads me beside still waters."),
      BibleVerse(verseNumber: 4, content: "He restores my soul."),
    ],
  ),
  BibleChapter(
    chapterNumber: 2,
    title: "The Heavens Declare",
    audioUrl: "assets/audio/chapter2.mp3",
    content:
        "The heavens declare the glory of God; the skies proclaim the work of His hands. Day after day they pour forth speech; night after night they display knowledge.",
    verses: [
      BibleVerse(
          verseNumber: 1, content: "The heavens declare the glory of God."),
      BibleVerse(
          verseNumber: 2, content: "The skies proclaim the work of His hands."),
      BibleVerse(
          verseNumber: 3, content: "Day after day they pour forth speech."),
      BibleVerse(
          verseNumber: 4, content: "Night after night they display knowledge."),
    ],
  ),
  BibleChapter(
    chapterNumber: 3,
    title: "God's Love Endures Forever",
    audioUrl: "assets/audio/chapter3.mp3",
    content:
        "Give thanks to the Lord, for He is good; His love endures forever. Let the redeemed of the Lord tell their story—those He redeemed from the hand of the foe.",
    verses: [
      BibleVerse(
          verseNumber: 1, content: "Give thanks to the Lord, for He is good."),
      BibleVerse(verseNumber: 2, content: "His love endures forever."),
      BibleVerse(
          verseNumber: 3,
          content: "Let the redeemed of the Lord tell their story."),
    ],
  ),
  BibleChapter(
    chapterNumber: 4,
    title: "The Light of the World",
    audioUrl: "assets/audio/chapter4.mp3",
    content:
        "The people walking in darkness have seen a great light; on those living in the land of deep darkness a light has dawned.",
    verses: [
      BibleVerse(
          verseNumber: 1,
          content: "The people walking in darkness have seen a great light."),
      BibleVerse(
          verseNumber: 2,
          content:
              "On those living in the land of deep darkness a light has dawned."),
    ],
  ),
  BibleChapter(
    chapterNumber: 5,
    title: "Trust in the Lord",
    audioUrl: "assets/audio/chapter5.mp3",
    content:
        "Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to Him, and He will make your paths straight.",
    verses: [
      BibleVerse(
          verseNumber: 1, content: "Trust in the Lord with all your heart."),
      BibleVerse(
          verseNumber: 2, content: "Lean not on your own understanding."),
      BibleVerse(verseNumber: 3, content: "In all your ways submit to Him."),
      BibleVerse(verseNumber: 4, content: "He will make your paths straight."),
    ],
  ),
];
