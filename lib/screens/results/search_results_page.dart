import 'package:flutter/material.dart';
import 'package:flutter_app/model/search_chparter_model.dart';
import 'package:flutter_app/screens/results/search_result_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SearchResultsPage extends StatelessWidget {
  final String initialQuery;

  const SearchResultsPage({super.key, required this.initialQuery});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => SearchViewModel(),
        onViewModelReady: (model) {
          model.updateQuery(initialQuery);
          model.search();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: TextField(
                    controller: viewModel.queryController,
                    autofocus: true,
                    onChanged: viewModel.updateQuery,
                    onSubmitted: (_) => viewModel.search(),
                    decoration: InputDecoration(
                      hintText: 'Search for verses, books, or keywords...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent, width: 2),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (viewModel.query.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: viewModel.clearQuery,
                            ),
                          IconButton(
                            icon: const Icon(Icons.search,
                                color: Colors.deepPurpleAccent),
                            onPressed: viewModel.search,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: viewModel.query.isEmpty
                  ? BuildInitialContent(viewModel.searchChapterModel)
                  : viewModel.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.searchChapterModel.data.verses.isEmpty
                          ? const Center(
                              child: Text(
                                'No results found.',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            )
                          : BuildResultsList(viewModel.searchChapterModel),
            ),
          );
        });
  }
}

class BuildInitialContent extends ViewModelWidget<SearchViewModel> {
  const BuildInitialContent(
    this.searchChapterModel, {
    super.key,
  });
  final SearchChapterModel searchChapterModel;
  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Searches',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: viewModel.recentSearches
              .map((search) => ActionChip(
                    label: Text(search),
                    onPressed: () {
                      viewModel.updateQuery(search);
                      viewModel.search();
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class BuildResultsList extends ViewModelWidget<SearchViewModel> {
  const BuildResultsList(
    this.searchChapterModel, {
    super.key,
  });
  final SearchChapterModel searchChapterModel;
  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return ListView.builder(
      itemCount: searchChapterModel.data.total > 10
          ? 10
          : searchChapterModel.data.total,
      itemBuilder: (context, index) {
        final result = searchChapterModel.data.verses[index];
        return GestureDetector(
          onTap: () {
            viewModel.handleNavigationSearchToChapReading(
              context,
              result.bibleId,
              result.chapterId,
              result.bookId,
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent.withOpacity(0.2),
                child: const Icon(Icons.book, color: Colors.deepPurpleAccent),
              ),
              title: Text(
                result.text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              subtitle: Text(
                result.chapterId,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.bookmark_border,
                        color: Colors.deepPurpleAccent),
                    onPressed: () {
                      // Implement bookmark toggle logic
                    },
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.share, color: Colors.deepPurpleAccent),
                    onPressed: () {
                      // Implement share functionality
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
