import 'package:flutter/material.dart';
import 'package:flutter_app/constants/books/americanStandard.dart';
import 'package:flutter_app/constants/books/bibleIDforTamil.dart';
import 'package:flutter_app/constants/books/bibleIDforTamil2.dart';
import 'package:flutter_app/constants/books/newInternational.dart';
import 'package:flutter_app/constants/books/newKingJames.dart';
import 'package:flutter_app/constants/variables.dart';
import 'package:flutter_app/provider/bible_id_provider.dart';
import 'package:flutter_app/screens/book_list_view/book_list_view.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:flutter_app/widgets/verse_slider.dart';
import 'package:flutter_app/widgets/version_card.dart';
import 'package:flutter_app/widgets/button_nav.dart';
import 'package:provider/provider.dart';

import '../../provider/language_provider.dart';

class BibleHomePage extends StatelessWidget {
  const BibleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String selectedLanguage =
        Provider.of<LanguageProvider>(context, listen: false).selectedLanguage;

    final List<Widget> languageCards = selectedLanguage == 'ta'
        ? [
            VersionCard(
              title: 'American Version',
              onTap: () {
                Provider.of<BibleIDProvider>(context, listen: false)
                    .setBibleID(bibleIDforTamil);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookListView(
                      books: Tamilbooks1,
                    ),
                  ),
                );

                // Provider.of<BibleIDProvider>(context, listen: false)
                //     .setBibleID(bibleIDforTamil);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const BookListView()),
                // );
              },
            ),
            VersionCard(
              title: 'New International',
              onTap: () {
                Provider.of<BibleIDProvider>(context, listen: false)
                    .setBibleID(bibleIDforTamil2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookListView(books: Tamilbooks2)),
                );
              },
            ),
          ]
        : [
            VersionCard(
              title: 'American Version',
              onTap: () {
                Provider.of<BibleIDProvider>(context, listen: false)
                    .setBibleID(americanStandard);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookListView(
                            books: americanStandardBooks,
                          )),
                );
              },
            ),
            VersionCard(
              title: 'New International',
              onTap: () {
                Provider.of<BibleIDProvider>(context, listen: false)
                    .setBibleID(newInternational);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookListView(
                            books: newInternationalBooks,
                          )),
                );
              },
            ),
            VersionCard(
              title: 'New King James',
              onTap: () {
                Provider.of<BibleIDProvider>(context, listen: false)
                    .setBibleID(newKingJames);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookListView(
                            books: newKingJamesBooks,
                          )),
                );
              },
            ),
          ];

    return Scaffold(
      backgroundColor: const Color(0xFFECECFF),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 100,
              ),
            ),
            CustomHeader(
              onBackPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Stack(
                      children: [
                        VerseSlider(),
                        // Positioned(
                        //   top: 70,
                        //   right: 0,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // Navigator.push(
                        //       //   context,
                        //       //   MaterialPageRoute(
                        //       //       builder: (context) => BookListView(
                        //       //           books: americanStandardBooks)),
                        //       // );
                        //     },
                        //     child: Container(
                        //       padding: const EdgeInsets.all(9),
                        //       alignment: Alignment.centerRight,
                        //       child: const Icon(
                        //         Icons.chevron_right,
                        //         color: Colors.black,
                        //         size: 28,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 41, 40, 61),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const SizedBox(height: 24),
                    // Dynamically render language cards
                    Column(
                      children: languageCards,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonNav(
        onHomePressed: () {
          // Handle Home button press
        },
        onMapPressed: () {
          // Handle Map button press
        },
        onFavoritePressed: () {
          // Handle Favorite button press
        },
        onProfilePressed: () {
          // Handle Profile button press
        },
      ),
    );
  }
}
