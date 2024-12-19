import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_full_view/book_full_view.dart';
import 'package:flutter_app/screens/favourite_book/favourite_Book_view_model.dart';
import 'package:flutter_app/tools/shimmer_effect.dart';
import 'package:flutter_app/widgets/button_nav.dart';
import 'package:flutter_app/widgets/custom_header.dart';
import 'package:flutter_app/widgets/history_card.dart';
import 'package:stacked/stacked.dart';

class FavouriteBookView extends StatelessWidget {
  const FavouriteBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouriteBookViewModel>.reactive(
        viewModelBuilder: () => FavouriteBookViewModel(),
        onViewModelReady: (model) {
          model.loadFavouriteBooks('user-id');
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
                      : viewModel.favouriteBooks.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Text(
                                "There is no favourite Book list",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Times'),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: viewModel.favouriteBooks.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.favouriteBooks[index];
                                  return HistoryCard(
                                    title: item["title"] ?? "",
                                    subTitle: item["abbreviation"] ?? "",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookFullView(
                                            abbreviation: item['abbreviation'],
                                            bibleId: item['bibleId'],
                                            imageUrl: item['imageUrl'],
                                            subTitle: item['subTitle'],
                                            summary: item['summary'],
                                            title: item['title'],
                                            id: item['id'],
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
