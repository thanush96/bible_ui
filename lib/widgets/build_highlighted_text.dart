import 'package:flutter/material.dart';

TextSpan buildHighlightedText(
    int verseNumber, String verseContent, List<String> highlightedVerses) {
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

  for (String highlight in highlightedVerses) {
    int matchIndex = remainingText.indexOf(highlight);

    if (matchIndex != -1) {
      // Add text before the highlighted portion
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

      // Add the highlighted text
      spans.add(TextSpan(
        text: highlight, // The matched text
        style: TextStyle(
          backgroundColor: Colors.yellow.shade200,
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Times',
        ),
      ));

      // Remove the matched portion from the remaining text
      remainingText = remainingText.substring(matchIndex + highlight.length);
    }
  }

  // Add any remaining text
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
