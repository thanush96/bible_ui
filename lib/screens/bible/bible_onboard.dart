import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../provider/language_provider.dart';
import 'bible_home.dart';

class BibleOnboard extends StatelessWidget {
  const BibleOnboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image Section
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/photos/vecteezy_woman_pray.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/logo.png',
                              width: 120,
                            ),
                            const SizedBox(height: 10),
                            Image.asset(
                              'assets/photos/bible_title.png',
                              width: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),

          // Bottom Container with Curved Corners
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                color: Color(0xFFECECFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(33),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/photos/ocean_text_style_effectfull.png',
                    width: 280,
                  ),
                  const Text(
                    'Reading & Listening',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8F96B0),
                      letterSpacing: 1.2,
                      fontFamily: 'Times',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        // English Button
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: globalGradient,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Update the language to English
                              Provider.of<LanguageProvider>(context,
                                      listen: false)
                                  .setLanguage('en');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BibleHomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'English',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Times',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Tamil Button
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: globalGradient,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Update the language to Tamil
                              Provider.of<LanguageProvider>(context,
                                      listen: false)
                                  .setLanguage('ta');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BibleHomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'தமிழ்',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
