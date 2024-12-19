import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  const HistoryCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              gradient: globalGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: 'Times'
                      // fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: 'Times'
                      // fontWeight: FontWeight.w500,
                      ),
                ),
                Container(
                  padding:
                      const EdgeInsets.all(5), // Adjust padding for circle size
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Makes the container circular
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF8F96B0),

                    // Arrow color inside the circle
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
