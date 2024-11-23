import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/values/app-font.dart';
import 'package:flutter_app/values/values.dart';

class SeeAllBooks extends StatelessWidget {
  static const routeName = "SeeAllBooks";
  const SeeAllBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Placeholder(),
            ),
          ),
          AppSpaces.verticalSpace20,
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                "Old Testament",
                style: TextStyle(
                  fontSize: AppFont.textSize18,
                  fontWeight: AppFont.fw400,
                  color: AppColors.greyTitle,
                ),
              ),
            ),
          ),
          Divider(
            color: AppColors.titleDivider,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          AppSpaces.verticalSpace20,

          //grid
          Expanded(
            child: RawScrollbar(
              thumbColor: AppColors.white,
              thickness: 10,
              trackColor: AppColors.scrollbarTrackColor,
              trackVisibility: true,
              trackRadius: const Radius.circular(5),
              padding: const EdgeInsets.only(right: 05),
              radius: const Radius.circular(5),
              thumbVisibility: true,
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return const BookCard(
                    title: "Bible Study",
                    subTitle: "Exodux",
                    actionText: "30 Days Online Lesson",
                  );
                },
              ),
            ),
          ),
        ],
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
                borderRadius: BorderRadius.circular(5),
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
                        const SizedBox(height: 4),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF000000),
                                Color(0xFF3533CD),
                                Color.fromRGBO(53, 51, 205, 0.68),
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
                              title,
                              style: TextStyle(
                                fontSize: AppFont.textSize12,
                                color: AppColors.white,
                                fontWeight: AppFont.fw400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subTitle,
                          style: TextStyle(
                            fontSize: AppFont.textSize14,
                            color: AppColors.white,
                            fontWeight: AppFont.fw400,
                          ),
                        ),
                        Text(
                          actionText,
                          style: TextStyle(
                            fontSize: AppFont.textSize14,
                            color: AppColors.white,
                            fontWeight: AppFont.fw400,
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
