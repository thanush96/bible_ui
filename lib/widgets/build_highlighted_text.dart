// import 'package:flutter/material.dart';

// TextSpan buildHighlightedText(
//     int? verseNumber,
//     String verseContent,
//     List<Map<String, dynamic>> highlightedVerses,
//     Map<String, dynamic> fontStyle) {
//   List<TextSpan> spans = [];

//   // Add the verse number as a separate span
//   if (verseNumber != null) {
//     spans.add(TextSpan(
//       text: '$verseNumber. ',
//       style: TextStyle(
//           color: const Color.fromARGB(255, 0, 0, 0),
//           fontFamily: fontStyle["_selectedFont"],
//           fontSize: double.parse(fontStyle["_fontSize"].toString())),
//     ));
//   }

//   String remainingText = verseContent;

//   // Iterate over all highlighted verses
//   for (var highlight in highlightedVerses) {
//     String highlightText = highlight['verse']; // The verse text to highlight
//     Color highlightColor = highlight['color']; // The color for the highlight

//     // Loop through remainingText to find all occurrences of the highlight text
//     int matchIndex;
//     while ((matchIndex = remainingText.indexOf(highlightText)) != -1) {
//       // Add any text before the highlighted portion
//       if (matchIndex > 0) {
//         spans.add(TextSpan(
//           text: remainingText.substring(0, matchIndex),
//           style: TextStyle(
//               color: Colors.black,
//               fontFamily: fontStyle["_selectedFont"],
//               fontSize: double.parse(fontStyle["_fontSize"].toString())),
//         ));
//       }

//       // Add the highlighted text portion
//       spans.add(TextSpan(
//         text: highlightText,
//         style: TextStyle(
//           backgroundColor: highlightColor,
//           color: Colors.black,
//           fontFamily: fontStyle["_selectedFont"],
//           fontSize: double.parse(fontStyle["_fontSize"].toString()),
//         ),
//       ));

//       // Update the remainingText after the highlighted portion
//       remainingText =
//           remainingText.substring(matchIndex + highlightText.length);
//     }
//   }

//   // Add any remaining text after all highlights
//   if (remainingText.isNotEmpty) {
//     spans.add(TextSpan(
//       text: remainingText,
//       style: TextStyle(
//         color: Colors.black,
//         fontFamily: fontStyle["_selectedFont"],
//         fontSize: double.parse(fontStyle["_fontSize"].toString()),
//       ),
//     ));
//   }

//   return TextSpan(children: spans);
// }

import 'package:flutter/material.dart';

TextSpan buildHighlightedText(
  int? verseNumber,
  String verseContent,
  List<Map<String, dynamic>> highlightedVerses,
  Map<String, dynamic> fontStyle,
  String findVerse,
) {
  List<TextSpan> spans = [];

  // Add the verse number as a separate span if available
  if (verseNumber != null) {
    spans.add(TextSpan(
      text: '$verseNumber. ',
      style: TextStyle(
        color: Colors.black,
        fontFamily: fontStyle["_selectedFont"],
        fontSize: double.parse(fontStyle["_fontSize"].toString()),
      ),
    ));
  }

  String remainingText = verseContent;

  int lastIndex = 0;

  // Combine regex matches and highlighted verses
  List<Map<String, dynamic>> combinedHighlights = [];

  // Regex to find "findVerse" in the verse content (matching exactly with spaces and punctuation)
  if (findVerse.isNotEmpty) {
    // Construct a regular expression that matches the findVerse exactly
    RegExp regExp = RegExp(
      RegExp.escape(findVerse), // Escaping only the necessary parts
      caseSensitive: false,
    );

    // Get matches from verseContent
    Iterable<Match> regexMatches = regExp.allMatches(verseContent);

    // Add regex matches to combined highlights
    for (var match in regexMatches) {
      combinedHighlights.add({
        'verse': match.group(0),
        'color': Colors.blue, // Blue for regex matches
        'type': 'regex',
        'index': match.start
      });
    }
  }

  // Sort highlighted verses by their position in the verseContent
  highlightedVerses.sort((a, b) => remainingText
      .indexOf(a['verse'])
      .compareTo(remainingText.indexOf(b['verse'])));

  // Add highlighted verses to combined highlights
  for (var highlight in highlightedVerses) {
    int index = remainingText.indexOf(highlight['verse']);
    if (index != -1) {
      combinedHighlights.add({
        'verse': highlight['verse'],
        'color': highlight['color'], // Highlight color
        'type': 'highlight',
        'index': index
      });
    }
  }

  // Sort combined highlights by position
  combinedHighlights.sort((a, b) => a['index'].compareTo(b['index']));

  // Process combined highlights
  for (var item in combinedHighlights) {
    String text = item['verse'];
    Color color = item['color'];
    int matchIndex = remainingText.indexOf(text, lastIndex);

    if (matchIndex == -1) {
      continue;
    }

    // Add any text before the current match
    if (matchIndex > lastIndex) {
      spans.add(TextSpan(
        text: remainingText.substring(lastIndex, matchIndex),
        style: TextStyle(
          color: Colors.black,
          fontFamily: fontStyle["_selectedFont"],
          fontSize: double.parse(fontStyle["_fontSize"].toString()),
        ),
      ));
    }

    // Add the matched text with appropriate color
    spans.add(TextSpan(
      text: text,
      style: TextStyle(
        color: item['type'] == 'regex' ? color : Colors.black,
        backgroundColor: item['type'] == 'highlight' ? color : null,
        fontFamily: fontStyle["_selectedFont"],
        fontSize: double.parse(fontStyle["_fontSize"].toString()),
      ),
    ));

    // Update lastIndex
    lastIndex = matchIndex + text.length;
  }

  // Add any remaining text after all matches
  if (lastIndex < remainingText.length) {
    spans.add(TextSpan(
      text: remainingText.substring(lastIndex),
      style: TextStyle(
        color: Colors.black,
        fontFamily: fontStyle["_selectedFont"],
        fontSize: double.parse(fontStyle["_fontSize"].toString()),
      ),
    ));
  }

  return TextSpan(children: spans);
}
