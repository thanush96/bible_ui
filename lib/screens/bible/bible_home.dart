import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/screens/book_list_view/book_list_view.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:flutter_app/widgets/verse_slider.dart';
import 'package:flutter_app/widgets/version_card.dart';

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
                              // Add your navigation action here (e.g., to next page)
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
                              builder: (context) =>
                                  // BibleReaderPage(),
                                  const BookListView()),
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: globalGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Container(
                decoration: BoxDecoration(
                  color: Colors.white, 
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(2), // Add padding for icon size balance
                child: IconButton(
                  icon: const Icon(Icons.home, color: Colors.black), // Icon color for active tab
                  onPressed: () {},
                ),
              ),
              // Inactive Tabs
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
