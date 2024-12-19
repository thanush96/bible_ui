// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_app/constants/constants.dart';
// import 'package:flutter_app/screens/book_full_view/book_full_view.dart';
// import 'package:flutter_app/screens/see_all_book/see_all_books.dart';
// import 'package:flutter_app/values/app-font.dart';
// import 'package:flutter_app/values/values.dart';
// import 'package:flutter_app/widgets/custom_header.dart';
// import 'package:flutter_app/widgets/button_nav.dart'; // Assuming you have this widget

// class BookListView extends StatelessWidget {
//   static const routeName = "BookListView";
//   const BookListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFECECFF),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Center(
//                 child: Image.asset(
//                   'assets/logo.png',
//                   height: 150,
//                 ),
//               ),
//               CustomHeader(
//                 onBackPressed: () => Navigator.pop(context),
//               ),
//               AppSpaces.verticalSpace10,
//               const HeaderDivider(
//                 headerCount: "65",
//                 headerText: "New Testament",
//               ),
//               AppSpaces.verticalSpace20,
//               _buildBookList(),
//               AppSpaces.verticalSpace20,
//               const HeaderDivider(
//                 headerCount: "69",
//                 headerText: "New Testament",
//               ),
//               AppSpaces.verticalSpace10,
//               _buildBookList(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: ButtonNav(
//         onHomePressed: () {
//           // Handle Home button press
//         },
//         onMapPressed: () {
//           // Handle Map button press
//         },
//         onFavoritePressed: () {
//           // Handle Favorite button press
//         },
//         onProfilePressed: () {
//           // Handle Profile button press
//         },
//       ),
//     );
//   }

//   // Extracted method to avoid code repetition
//   Widget _buildBookList() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       child: SizedBox(
//         height: 250,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const BookFullView(),
//                   ),
//                 );
//               },
//               child: const BookCard(
//                 title: 'Bible Study',
//                 subTitle: 'Exodus',
//                 actionText: '30 Days Online Lesson',
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class BookCard extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   final String actionText;
//   const BookCard({
//     super.key,
//     required this.title,
//     required this.subTitle,
//     required this.actionText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10),
//       child: Stack(
//         children: [
//           Container(
//             width: 200,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               image: const DecorationImage(
//                 image: AssetImage('assets/john.webp'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 8,
//                 right: 8,
//                 top: 8,
//               ),
//               child: ClipRRect(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(
//                     sigmaX: 3,
//                     sigmaY: 3,
//                   ),
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     color: AppColors.black.withOpacity(0.2),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         AppSpaces.verticalSpace04,
//                         Container(
//                           height: 30,
//                           decoration: BoxDecoration(
//                             gradient: globalGradient,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // Handle button tap
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                             ),
//                             child: Text(
//                               title,
//                               style: TextStyle(
//                                 fontSize: AppFont.textSize12,
//                                 color: AppColors.white,
//                                 fontWeight: AppFont.fw400,
//                               ),
//                             ),
//                           ),
//                         ),
//                         AppSpaces.verticalSpace06,
//                         Text(
//                           subTitle,
//                           style: TextStyle(
//                             fontSize: AppFont.textSize12,
//                             fontWeight: AppFont.fw400,
//                             color: AppColors.white,
//                           ),
//                         ),
//                         Text(
//                           actionText,
//                           style: TextStyle(
//                             fontWeight: AppFont.fw400,
//                             fontSize: AppFont.textSize12,
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HeaderDivider extends StatelessWidget {
//   final String headerText;
//   final String headerCount;
//   final String actionText;
//   const HeaderDivider({
//     super.key,
//     required this.headerText,
//     required this.headerCount,
//     this.actionText = "See All",
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "$headerText ($headerCount)",
//                 style: TextStyle(
//                   fontSize: AppFont.textSize18,
//                   fontWeight: AppFont.fw400,
//                   color: AppColors.greyTitle,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const SeeAllBooks(),
//                     ),
//                   );
//                 },
//                 child: Text(
//                   actionText,
//                   style: TextStyle(
//                     fontSize: AppFont.textSize18,
//                     fontWeight: AppFont.fw400,
//                     color: AppColors.greyTitle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: 2,
//             color: AppColors.titleDivider,
//             width: double.infinity,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_list_view/book_list.dart';
import 'package:flutter_app/screens/book_list_view/header_devider.dart';
import 'package:flutter_app/values/values.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:flutter_app/widgets/button_nav.dart'; // Assuming you have this widget

class BookListView extends StatelessWidget {
  static const routeName = "BookListView";
  final List<Map<String, String>> books;

  const BookListView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 150,
                ),
              ),
              CustomHeader(
                onBackPressed: () => Navigator.pop(context),
              ),
              AppSpaces.verticalSpace10,
              const HeaderDivider(
                headerCount: "65",
                headerText: "New Testament",
              ),
              AppSpaces.verticalSpace20,
              BookList(
                books: books,
              ),
              AppSpaces.verticalSpace20,
              const HeaderDivider(
                headerCount: "69",
                headerText: "New Testament",
              ),
              AppSpaces.verticalSpace10,
              BookList(
                books: books,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtonNav(),
    );
  }
}
