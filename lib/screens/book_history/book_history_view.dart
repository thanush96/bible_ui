import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bible/bible_reader.dart';
import 'package:flutter_app/screens/book_history/Book_history_view_model.dart';
import 'package:flutter_app/tools/shimmer_effect.dart';
import 'package:flutter_app/widgets/button_nav.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:flutter_app/widgets/history_card.dart';
import 'package:stacked/stacked.dart';

class BookHistoryView extends StatelessWidget {
  const BookHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookHistoryViewModel>.reactive(
        viewModelBuilder: () => BookHistoryViewModel(),
        onViewModelReady: (model) {
          model.loadChapterIdsAndBookIds();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            bottomNavigationBar: ButtonNav(
              selectedIndex: 1,
            ),
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
                  viewModel.isBusy
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: ShimmerEffect(
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : viewModel.chapterData.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Text(
                                "There is no hisory",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Times'),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: viewModel.chapterData.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.chapterData[index];
                                  return HistoryCard(
                                    title: item["id"] ?? "",
                                    subTitle: item["bookId"] ?? "",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BibleReaderPage(
                                            bibleId: item["bibleId"] ?? "",
                                            chapterId: item["id"] ?? "",
                                            bookId: item["bookId"] ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                ],
              ),
            ),
          );
        });
  }
}
