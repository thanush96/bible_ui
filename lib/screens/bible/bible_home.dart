import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/widgets/bible_reader.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:flutter_app/widgets/verse_slider.dart';
import 'package:flutter_app/widgets/version_card.dart';

class BibleHomePage extends StatelessWidget {
  const BibleHomePage({Key? key}) : super(key: key);

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
                height: 150,
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
                    const VerseSlider(),
                    const SizedBox(height: 24),

                    // Divider after VerseSlider
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
                              builder: (context) => const BibleReaderPage()),
                        );
                      },
                    ),
                    VersionCard(
                      title: 'New International',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BibleReaderPage()),
                        );
                      },
                    ),
                    VersionCard(
                      title: 'New King James',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BibleReaderPage()),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: globalGradient,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.map, color: Colors.white54),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white54),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white54),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
