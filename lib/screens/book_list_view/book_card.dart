import 'dart:ui';

import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../tools/shimmer_effect.dart';
import '../../values/app-font.dart';
import '../../values/values.dart';
import '../book_full_view/book_full_view.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;

  const BookCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const BookFullView(), // Navigate to BookFullView
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                FutureBuilder(
                  future: _loadImage(imageUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildSkeletonLoader();
                    } else if (snapshot.hasData &&
                        snapshot.data is String &&
                        snapshot.data!.isNotEmpty) {
                      return Container(
                        width: 200,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // image: DecorationImage(
                          //   image: NetworkImage(snapshot.data as String),
                          //   fit: BoxFit.cover,
                          // )

                          image: const DecorationImage(
                            image: AssetImage('assets/john.webp'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return _buildErrorPlaceholder();
                    }
                  },
                ),
                _buildDetailsOverlay(context),
              ],
            ),
          ),
        ));
  }

  Widget _buildSkeletonLoader() {
    return ShimmerEffect(
      child: Container(
        width: 200,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      child: const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  Widget _buildDetailsOverlay(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          top: 0,
          bottom: 10,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: AppColors.black.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSpaces.verticalSpace04,
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: globalGradient,
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
                  AppSpaces.verticalSpace06,
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: AppFont.textSize12,
                      fontWeight: AppFont.fw400,
                      color: AppColors.white,
                    ),
                  ),
                  // Text(
                  //   actionText,
                  //   style: TextStyle(
                  //     fontWeight: AppFont.fw400,
                  //     fontSize: AppFont.textSize12,
                  //     color: AppColors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _loadImage(String url) async {
    // Simulate network delay for testing
    await Future.delayed(const Duration(seconds: 2));
    return url;
  }
}
