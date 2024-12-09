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

  // Sort highlights by position to ensure correct ordering
  highlightedVerses.sort((a, b) => remainingText
      .indexOf(a['verse'])
      .compareTo(remainingText.indexOf(b['verse'])));

  int lastIndex = 0;

  // Iterate through all highlighted verses
  for (var highlight in highlightedVerses) {
    String highlightText = highlight['verse'];
    Color highlightColor = highlight['color'];

    int matchIndex = remainingText.indexOf(highlightText, lastIndex);

    if (matchIndex == -1) {
      // If the highlight text is not found, skip this highlight
      continue;
    }

    // Add text before the highlighted portion
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

    // Add the highlighted text portion
    spans.add(TextSpan(
      text: highlightText,
      style: TextStyle(
        backgroundColor: highlightColor,
        color: Colors.black,
        fontFamily: fontStyle["_selectedFont"],
        fontSize: double.parse(fontStyle["_fontSize"].toString()),
      ),
    ));

    // Update lastIndex to the end of the current match
    lastIndex = matchIndex + highlightText.length;
  }

  // Add any remaining text after all highlights
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
