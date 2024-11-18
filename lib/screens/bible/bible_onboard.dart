import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/screens/bible/bible_home.dart';

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
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/splashImage.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: Center(
                  //   child: Image.asset(
                  //     'assets/logo.png',
                  //     width: 200,
                  //   ),
                  // ),
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
                color: Color(0xFFECECFF), // Set the background color to red
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(33),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Music Bible Logo
                  Image.asset(
                    'assets/logo.png',
                    width: 60,
                  ),
                  const SizedBox(height: 8),
                  // Reading & Listening Text
                  const Text(
                    'Reading & Listening',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8F96B0), // Text color
                        letterSpacing: 1.2,
                        fontFamily: 'Times'),
                  ),
                  const SizedBox(height: 20),
                  // Language Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        // English Button
                        Container(
                          width: 200,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: globalGradient,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BibleHomePage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 255, 255, 255), // Transparent background
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
                                  fontFamily: 'Times'),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Tamil Button
                        Container(
                          width: 200,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: globalGradient,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BibleHomePage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.transparent, // Transparent background
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'தமிழ்',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
