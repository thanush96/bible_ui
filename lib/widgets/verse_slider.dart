import 'package:flutter/material.dart';

class VerseSlider extends StatefulWidget {
  const VerseSlider({Key? key}) : super(key: key);

  @override
  State<VerseSlider> createState() => _VerseSliderState();
}

class _VerseSliderState extends State<VerseSlider> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30,),
          child: Text(
            'Today Verses:',
            style: TextStyle(
                color: Color(0xFF3533CD),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Times'),
          ),
        ),
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 30 , vertical: 15),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'But The best now in the middle of the sea,by the waves thge wind was contrart.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontFamily: 'Times',
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Romans 8:1',
                      style: TextStyle(
                          color: Color.fromARGB(255, 155, 155, 155),
                          fontSize: 14,
                          fontFamily: 'Times'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              width: 10,
              height: 10,
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
