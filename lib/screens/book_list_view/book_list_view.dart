import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_full_view/book_full_view.dart';
import 'package:flutter_app/screens/see_all_book/see_all_books.dart';
import 'package:flutter_app/values/app-font.dart';
import 'package:flutter_app/values/values.dart';

class BookListView extends StatelessWidget {
  static const routeName = "BookListView";
  const BookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Placeholder(
                fallbackHeight: 60,
                fallbackWidth: 60,
              ),
              AppSpaces.verticalSpace20,
              const HeaderDivider(
                headerCount: "65",
                headerText: "New Testamwent",
              ),
              AppSpaces.verticalSpace20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookFullView(),
                            ),
                          );
                        },
                        child: const BookCard(
                          title: 'Bible Study',
                          subTitle: 'Exodux',
                          actionText: '30 Days Online Lesson',
                        ),
                      );
                    },
                  ),
                ),
              ),
              AppSpaces.verticalSpace20,
              const HeaderDivider(
                headerCount: "69",
                headerText: "New Testamwent",
              ),
              AppSpaces.verticalSpace10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookFullView(),
                            ),
                          );
                        },
                        child: const BookCard(
                          title: 'Bible Study',
                          subTitle: 'Exodux',
                          actionText: '30 Days Online Lesson',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String actionText;
  const BookCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://m.media-amazon.com/images/I/914pEgyd14L._AC_UF894,1000_QL80_.jpg', // Replace with your image URL
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 3,
                    sigmaY: 3,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: AppColors.white.withOpacity(0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppSpaces.verticalSpace04,
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(
                                  0xFF000000,
                                ),
                                Color(
                                  0xFF3533CD,
                                ),
                                Color.fromRGBO(
                                  53,
                                  51,
                                  205,
                                  0.68,
                                ),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle button tap
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              "Bible Study",
                              style: TextStyle(
                                fontSize: AppFont.textSize12,
                                color: AppColors.white,
                                fontWeight: AppFont.fw400,
                              ),
                            ),
                          ),
                        ),
                        AppSpaces.verticalSpace06,
                        Text(
                          "Exodux",
                          style: TextStyle(
                            fontSize: AppFont.textSize12,
                            fontWeight: AppFont.fw400,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "30 Days Online Lesson",
                          style: TextStyle(
                            fontWeight: AppFont.fw400,
                            fontSize: AppFont.textSize12,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderDivider extends StatelessWidget {
  final String headerText;
  final String headerCount;
  final String actionText;
  const HeaderDivider(
      {super.key,
      required this.headerText,
      required this.headerCount,
      this.actionText = "See All"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$headerText ($headerCount)",
                style: TextStyle(
                  fontSize: AppFont.textSize18,
                  fontWeight: AppFont.fw400,
                  color: AppColors.greyTitle,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SeeAllBooks(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: AppFont.textSize18,
                    fontWeight: AppFont.fw400,
                    color: AppColors.greyTitle,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 2,
            color: AppColors.titleDivider,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
