import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/verses/english_verse.dart';
import '../constants/verses/tamil_verse.dart';
import '../provider/language_provider.dart';
import '../screens/bible/bible_reader.dart';

class VerseSlider extends StatefulWidget {
  const VerseSlider({Key? key}) : super(key: key);

  @override
  State<VerseSlider> createState() => _VerseSliderState();
}

class _VerseSliderState extends State<VerseSlider> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  Timer? _autoSlideTimer;
  List<Map<String, String>> randomVerses = [];

  @override
  void initState() {
    super.initState();
    _pickRandomVerses();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _pickRandomVerses() {
    final random = Random();

    final String selectedLanguage =
        Provider.of<LanguageProvider>(context, listen: false).selectedLanguage;

    randomVerses = List.from(selectedLanguage == 'ta' ? taVerses : enVerses)
      ..shuffle(random);
    randomVerses = randomVerses.take(3).toList();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < randomVerses.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Today\'s Verses:',
            style: TextStyle(
              color: Color(0xFF3533CD),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Times',
            ),
          ),
        ),
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: randomVerses.length,
            itemBuilder: (context, index) {
              final verse = randomVerses[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BibleReaderPage(
                          bibleId: verse['bibleId']!,
                          chapterId: verse['chapterId']!,
                          bookId: verse['bookId']!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FC),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          verse["content"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontFamily: 'Times',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          verse["reference"]!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 155, 155, 155),
                            fontSize: 13,
                            fontFamily: 'Times',
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            randomVerses.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              width: currentPage == index ? 12 : 10,
              height: currentPage == index ? 12 : 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index
                    ? const Color(0xFF3533CD)
                    : const Color.fromARGB(255, 128, 126, 226),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
