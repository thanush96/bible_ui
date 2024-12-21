import 'package:flutter/material.dart';

import '../screens/bible/bible_reader.dart';

class LinkPreview extends StatelessWidget {
  final String content;
  final String bibleId;
  final String bookName;
  final String chapterNumber;
  final String userName;

  const LinkPreview({
    super.key,
    required this.content,
    required this.bibleId,
    required this.bookName,
    required this.chapterNumber,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          BibleReaderPage(
            bibleId: bibleId,
            chapterId: chapterNumber,
            bookId: bookName,
          );
        },
        child: Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$bookName $chapterNumber',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Shared by $userName',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
