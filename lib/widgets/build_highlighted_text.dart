import 'package:flutter/material.dart';

TextSpan buildHighlightedText(int verseNumber, String verseContent,
    List<Map<String, dynamic>> highlightedVerses) {
  List<TextSpan> spans = [];

  // Add the verse number as a separate span
  spans.add(TextSpan(
    text: '$verseNumber. ',
    style: const TextStyle(
      color: Color.fromARGB(255, 145, 3, 3),
      fontFamily: 'Times',
      fontSize: 18,
    ),
  ));

  String remainingText = verseContent;

  // Iterate over all highlighted verses
  for (var highlight in highlightedVerses) {
    String highlightText = highlight['verse']; // The verse text to highlight
    Color highlightColor = highlight['color']; // The color for the highlight

    // Loop through remainingText to find all occurrences of the highlight text
    int matchIndex;
    while ((matchIndex = remainingText.indexOf(highlightText)) != -1) {
      // Add any text before the highlighted portion
      if (matchIndex > 0) {
        spans.add(TextSpan(
          text: remainingText.substring(0, matchIndex),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Times',
          ),
        ));
      }

      // Add the highlighted text portion
      spans.add(TextSpan(
        text: highlightText,
        style: TextStyle(
          backgroundColor: highlightColor,
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Times',
        ),
      ));

      // Update the remainingText after the highlighted portion
      remainingText =
          remainingText.substring(matchIndex + highlightText.length);
    }
  }

  // Add any remaining text after all highlights
  if (remainingText.isNotEmpty) {
    spans.add(TextSpan(
      text: remainingText,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Times',
      ),
    ));
  }

  return TextSpan(children: spans);
}
