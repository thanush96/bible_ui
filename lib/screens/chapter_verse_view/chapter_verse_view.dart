import 'package:flutter/material.dart';
import 'package:flutter_app/constants/book_data.dart';
import 'package:flutter_app/model/chapter_list_model.dart';
import 'package:flutter_app/model/chapter_verses_model.dart';
import 'package:flutter_app/screens/bible/bible_reader.dart';
import 'package:flutter_app/screens/chapter_verse_view/chapter_verse_view_model.dart';
import 'package:flutter_app/services/http_service.dart';
import 'package:flutter_app/tools/chap_verse_loader.dart';
import 'package:flutter_app/tools/skeleton_loader.dart';
import 'package:flutter_app/tools/skeleton_loader_books.dart';
import 'package:flutter_app/values/app-font.dart';
import 'package:flutter_app/values/values.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stacked/stacked.dart';

class ChapterVerseView extends StatelessWidget {
  static const routeName = "ChapterVerseView";
  ChapterVerseView({
    super.key,
    this.initialIndex = 0,
    required this.bibleId,
    required this.bookId,
    required this.chapterId,
  });
  final int initialIndex;
  String bibleId;
  String chapterId;
  String bookId;

  final ScrollController _booksScrollController = ScrollController();

  final ScrollController _numbersScrollController1 = ScrollController();

  final ScrollController _numbersScrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChapterVerseViewModel>.reactive(
        viewModelBuilder: () => ChapterVerseViewModel(),
        onViewModelReady: (model) {
          model.setBusyForLoad();
          model.updateInitialParams(bibleId);
          model.chapterListFetch(bibleId, bookId);
          model.bookDetailFetch(bibleId, bookId);
          model.bookVerseFetch(bibleId, chapterId);
        },
        builder: (context, model, _) {
          return DefaultTabController(
            initialIndex: initialIndex,
            length: 3, // Define the number of tabs
            child: SafeArea(
              child: Scaffold(
                backgroundColor: const Color(0xFFECECFF),
                body: Column(
                  children: [
                    CustomHeader(
                      onBackPressed: () => Navigator.pop(context),
                    ),
                    (model.isBusyBook)
                        ? const SkeletonLoaderBooks()
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                0,
                                            height: 240,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AppSpaces.verticalSpace20,
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            print(
                                                                "Volume Icon tapped!");
                                                          },
                                                          child: Icon(
                                                            Ionicons
                                                                .volume_high,
                                                            size: 20,
                                                            color: AppColors
                                                                .grey500,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        InkWell(
                                                          child: Icon(
                                                            Ionicons
                                                                .share_social,
                                                            size: 20,
                                                            color: AppColors
                                                                .grey700,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          model.bookDetailModel
                                                                  ?.data.name ??
                                                              "",
                                                          style: TextStyle(
                                                            fontSize: AppFont
                                                                .textSize18,
                                                            color: AppColors
                                                                .greyTitle,
                                                            fontWeight:
                                                                AppFont.fw400,
                                                          ),
                                                        ),
                                                        AppSpaces
                                                            .verticalSpace06,
                                                        Text(
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          model
                                                                  .bookDetailModel
                                                                  ?.data
                                                                  .nameLong ??
                                                              "",
                                                          style: TextStyle(
                                                            fontSize: AppFont
                                                                .textSize16,
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                AppFont.fw400,
                                                          ),
                                                        ),

                                                        AppSpaces
                                                            .verticalSpace20,
                                                        const SizedBox(
                                                            height: 8),
                                                        // Row with button and favorite icon
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      const LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                        0xFF000000,
                                                                      ),
                                                                      Color(
                                                                        0xFF3533CD,
                                                                      ),
                                                                      Color
                                                                          .fromRGBO(
                                                                        53,
                                                                        51,
                                                                        205,
                                                                        0.68,
                                                                      ),
                                                                    ],
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {},
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    shadowColor:
                                                                        Colors
                                                                            .transparent,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          0,
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
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          AppFont
                                                                              .textSize16,
                                                                      color: AppColors
                                                                          .white,
                                                                      fontWeight:
                                                                          AppFont
                                                                              .fw400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                Ionicons
                                                                    .heart_outline,
                                                                color: AppColors
                                                                    .grey700,
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

                                  // Tab Section
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        360,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 20,
                                      ),
                                      child: Column(
                                        children: [
                                          // TabBar
                                          TabBar(
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            dividerColor: Colors.transparent,
                                            indicator: const BoxDecoration(
                                              gradient: LinearGradient(
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
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: AppFont.textSize18,
                                              fontWeight: AppFont.fw400,
                                              fontFamily: 'Times-New-Roman',
                                            ),
                                            labelColor: AppColors.white,
                                            unselectedLabelColor:
                                                AppColors.greyTitle,
                                            tabs: const [
                                              Tab(
                                                text: "Book",
                                              ),
                                              Tab(text: "Chapters"),
                                              Tab(text: "Verse"),
                                            ],
                                          ),
                                          Divider(
                                            endIndent: 10,
                                            color: AppColors.titleDivider,
                                            thickness: 2,
                                          ),
                                          // TabBarView
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                //Books
                                                _buildTabContentBooks(
                                                  scrollController:
                                                      _booksScrollController,
                                                  books: books,
                                                  //  [

                                                  //   Book(
                                                  //     title: 'HarryPotter',
                                                  //     subtitle:
                                                  //         'Harry Potter and the Philosophers Stone Potter and the Philosophers Stone Potter and the Philosophers Stone Potter and the Philosophers Stone was published and the Philosophers Stone was published  Harry Potter and the Philosophers Stone was publishe  Harry Potter and the Philosophers Stone was publisheby Bloomsbury, the publis',
                                                  //     imageUrl:
                                                  //         'https://assets.brightspot.abebooks.a2z.com/dims4/default/476b907/2147483647/strip/true/crop/360x420+0+0/resize/360x420!/format/jpg/quality/90/?url=http%3A%2F%2Fabebooks-brightspot.s3.us-west-2.amazonaws.com%2F2c%2Fb5%2F5d9a711f4f278c343574740b8da3%2Fgoblet-fire.png',
                                                  //   ),
                                                  // ],
                                                ),
                                                //Chapter
                                                _buildTabContent(
                                                  chapterData: model
                                                      .chapterListDataViewModel[
                                                          0]
                                                      .data,
                                                  scrollController:
                                                      _numbersScrollController1,
                                                ),
                                                //Verses
                                                _buildTabContentForVerses(
                                                  chapterVersesData: model
                                                      .chapterVersesModel?.data,
                                                  scrollController:
                                                      _numbersScrollController2,
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
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

//Chapter
class _buildTabContent extends ViewModelWidget<ChapterVerseViewModel> {
  _buildTabContent({
    required this.scrollController,
    this.chapterData,
    super.key,
  });
  List<ChapterData>? chapterData;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context, ChapterVerseViewModel viewModel) {
    return RawScrollbar(
      controller: scrollController,
      thumbColor: AppColors.white,
      thickness: 10,
      trackColor: AppColors.scrollbarTrackColor,
      trackVisibility: true,
      trackRadius: const Radius.circular(5),
      padding: const EdgeInsets.only(right: 05),
      radius: const Radius.circular(5),
      thumbVisibility: true,
      child:
          // viewModel.isBusyChapterLoad
          //     ? ChapVerseLoader(
          //         scrollController: scrollController,
          //         count: 5,
          //       )
          //     :
          GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
        controller: scrollController,
        // physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: chapterData?.length,
        itemBuilder: (context, index) {
          final number = index + 1;
          final chapterDetails = chapterData;
          return GestureDetector(
            onTap: () {
              viewModel.bookVerseFetch(
                  viewModel.BibleID, chapterDetails?[index].id ?? "");
              DefaultTabController.of(context).animateTo(2);
              printStatement(chapterDetails?[index].id);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppFont.textSize18,
                    fontWeight: AppFont.fw400,
                    fontFamily: 'Times-New-Roman',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//Verse
class _buildTabContentForVerses extends ViewModelWidget<ChapterVerseViewModel> {
  _buildTabContentForVerses({
    required this.scrollController,
    this.chapterVersesData,
    super.key,
  });
  List<ChapterVersesData>? chapterVersesData;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context, ChapterVerseViewModel viewModel) {
    return RawScrollbar(
      controller: scrollController,
      thumbColor: AppColors.white,
      thickness: 10,
      trackColor: AppColors.scrollbarTrackColor,
      trackVisibility: true,
      trackRadius: const Radius.circular(5),
      padding: const EdgeInsets.only(right: 05),
      radius: const Radius.circular(5),
      thumbVisibility: true,
      child: viewModel.isBusyChapterLoad
          ? ChapVerseLoader(
              scrollController: scrollController,
              count: 5,
            )
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
              controller: scrollController,
              // physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: chapterVersesData?.length,
              itemBuilder: (context, index) {
                final number = index + 1;
                final chapterDetails = chapterVersesData;
                return GestureDetector(
                  onTap: () {
                    printStatement(chapterDetails?[index].id);
                    viewModel.versesContentFetch(viewModel.BibleID,
                        chapterDetails?[index].orgId ?? "", context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppFont.textSize18,
                          fontWeight: AppFont.fw400,
                          fontFamily: 'Times-New-Roman',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

//Books
class _buildTabContentBooks extends ViewModelWidget<ChapterVerseViewModel> {
  const _buildTabContentBooks({
    required this.books,
    required this.scrollController,
    super.key,
  });
  final List<Map<String, String>> books;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context, ChapterVerseViewModel viewModel) {
    return RawScrollbar(
      controller: scrollController,
      thumbColor: AppColors.white,
      thickness: 10,
      trackColor: AppColors.scrollbarTrackColor,
      trackVisibility: true,
      trackRadius: const Radius.circular(5),
      padding: const EdgeInsets.only(right: 05),
      radius: const Radius.circular(5),
      thumbVisibility: true,
      child: ListView.builder(
        controller: scrollController,
        // physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              viewModel.setBusyForLoad();
              DefaultTabController.of(context).animateTo(1);
              viewModel.bookDetailFetch(
                  book['bibleId'] ?? "", book['id'] ?? "");
              //  viewModel.setIsBusyChapterLoad = true;
              viewModel.chapterListDataViewModel.clear();
              viewModel.chapterListFetch(
                  book['bibleId'] ?? "", book['id'] ?? "");
            },
            child: Container(
              width: 60,
              height: 130,
              margin: const EdgeInsets.symmetric(vertical: 05),
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
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
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      'https://assets.brightspot.abebooks.a2z.com/dims4/default/476b907/2147483647/strip/true/crop/360x420+0+0/resize/360x420!/format/jpg/quality/90/?url=http%3A%2F%2Fabebooks-brightspot.s3.us-west-2.amazonaws.com%2F2c%2Fb5%2F5d9a711f4f278c343574740b8da3%2Fgoblet-fire.png',
                      width: 60,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Book name : ${book['name']}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppFont.textSize12,
                                fontWeight: AppFont.fw400,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              "Author Name : ${book['nameLong']}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppFont.textSize12,
                                fontWeight: AppFont.fw400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Sample Book class to hold book data
class Book {
  final String title;
  final String subtitle;
  final String imageUrl;

  Book({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
