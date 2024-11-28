import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_list_view/book_list_view.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:flutter_app/widgets/verse_slider.dart';
import 'package:flutter_app/widgets/version_card.dart';
import 'package:flutter_app/widgets/button_nav.dart'; // Import the ButtonNav widget

class BibleHomePage extends StatelessWidget {
  const BibleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Stack(
                      children: [
                        const VerseSlider(),
                        Positioned(
                          top: 70,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BookListView()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(9),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.chevron_right,
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 41, 40, 61), // Divider color
                      thickness: 1, // Thickness of the divider line
                      indent: 20, // Space from the left
                      endIndent: 20, // Space from the right
                    ),
                    const SizedBox(height: 24),
                    VersionCard(
                      title: 'American Version',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookListView()),
                        );
                      },
                    ),
                    VersionCard(
                      title: 'New International',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookListView()),
                        );
                      },
                    ),
                    VersionCard(
                      title: 'New King James',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookListView()),
                        );
                      },
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
