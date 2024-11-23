import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chapter_verse_view/chapter_verse_view.dart';
import 'package:flutter_app/values/app-font.dart';
import 'package:flutter_app/values/values.dart';
import 'package:ionicons/ionicons.dart';

class BookFullView extends StatelessWidget {
  static const routeName = "BookFullView";
  const BookFullView({super.key});

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        //backGrey
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 10,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 0,
                            height: 240,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 0,
                        //   left: 0,
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 5,
                              child: Container(
                                // width: (MediaQuery.of(context).size.width / 3)

                                height: 220,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://i.ibb.co/SNkhdQp/Twitter-Post-Frame-1-removebg-preview.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            AppSpaces.horizontalSpace10,
                            Flexible(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  top: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppSpaces.verticalSpace20,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print("Volume Icon tapped!");
                                          },
                                          child: Icon(
                                            Ionicons.volume_high,
                                            size: 20,
                                            color: AppColors.grey500,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        InkWell(
                                          child: Icon(
                                            Ionicons.share_social,
                                            size: 20,
                                            color: AppColors.grey700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Bible Study",
                                          style: TextStyle(
                                            fontSize: AppFont.textSize14,
                                            color: AppColors.greyTitle,
                                            fontWeight: AppFont.fw400,
                                          ),
                                        ),
                                        AppSpaces.verticalSpace06,
                                        Text(
                                          "Exodux Bible Study",
                                          style: TextStyle(
                                            fontSize: AppFont.textSize16,
                                            color: AppColors.black,
                                            fontWeight: AppFont.fw400,
                                          ),
                                        ),
                                        Text(
                                          "30 Days Online Lesson ",
                                          style: TextStyle(
                                            fontSize: AppFont.textSize16,
                                            color: AppColors.black,
                                            fontWeight: AppFont.fw400,
                                          ),
                                        ),
                                        AppSpaces.verticalSpace20,
                                        Text(
                                          "Abraham",
                                          style: TextStyle(
                                            fontSize: AppFont.textSize16,
                                            color: AppColors.black,
                                            fontWeight: AppFont.fw400,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Row with button and favorite icon
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 15,
                                                      vertical: 0,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Add Favourite",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppFont.textSize16,
                                                      color: AppColors.white,
                                                      fontWeight: AppFont.fw400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Ionicons.heart_outline,
                                                color: AppColors.grey700,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSpaces.verticalSpace20,

                  // Summary & Readings
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                            fontSize: AppFont.textSize20,
                            color: AppColors.greyTitle,
                            fontWeight: AppFont.fw400,
                          ),
                        ),
                        Divider(
                          color: AppColors.titleDivider,
                          thickness: 2,
                        ),
                        AppSpaces.verticalSpace10,
                        Text(
                          "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests.",
                          style: TextStyle(
                            fontSize: AppFont.textSize14,
                            color: AppColors.black,
                            fontWeight: AppFont.fw400,
                          ),
                        ),
                        AppSpaces.verticalSpace20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Chapters",
                              style: TextStyle(
                                fontSize: AppFont.textSize20,
                                color: AppColors.greyTitle,
                                fontWeight: AppFont.fw400,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Readings",
                                  style: TextStyle(
                                    fontSize: AppFont.textSize20,
                                    color: AppColors.greyTitle,
                                    fontWeight: AppFont.fw400,
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    size: 28,
                                    Ionicons.arrow_forward,
                                    color: AppColors.greyTitle,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChapterVerseView(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: AppColors.titleDivider,
                          thickness: 2,
                        ),
                        AppSpaces.verticalSpace10,
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "John Chapter 01",
                                  style: TextStyle(
                                    fontSize: AppFont.textSize14,
                                    color: AppColors.scrollbarTrackColor,
                                    fontWeight: AppFont.fw400,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.chevron_down,
                                      size: 20,
                                      color: AppColors.scrollbarTrackColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpaces.verticalSpace10,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF000000),
                                              Color(0xFF3533CD),
                                              Color.fromRGBO(53, 51, 205, 0.68),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Ionicons.volume_high,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //  AppSpaces.verticalSpace10,
                                Text(
                                  "This section provides a detailed overview of the book content. It gives insights about the major themes, storyline, and key points discussed in the book, helping you decide if it matches your interests.",
                                  style: TextStyle(
                                    fontSize: AppFont.textSize14,
                                    color: AppColors.black,
                                    fontWeight: AppFont.fw400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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

// Helper method to build tab content
