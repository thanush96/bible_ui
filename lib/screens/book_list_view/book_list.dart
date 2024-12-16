import 'package:flutter/material.dart';
import 'book_card.dart';

class BookList extends StatelessWidget {
  final List<Map<String, String>> books;

  const BookList({super.key, required this.books});

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
            title: book['name'] ?? "",
            id: book['id'] ?? "",
            subTitle: book['nameLong'] ?? "",
            imageUrl: book['imageUrl'] ?? "",
            abbreviation: book['abbreviation'] ?? "",
            bibleId: book['bibleId'] ?? "",
            summary: book['summary'] ?? "",
          );
        },
      ),
    );
  }
}
