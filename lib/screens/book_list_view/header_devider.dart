import 'package:flutter/material.dart';

import '../../values/app-font.dart';
import '../../values/values.dart';
import '../see_all_book/see_all_books.dart';

class HeaderDivider extends StatelessWidget {
  final String headerText;
  final String headerCount;
  final String actionText;
  const HeaderDivider({
    super.key,
    required this.headerText,
    required this.headerCount,
    this.actionText = "See All",
  });

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
