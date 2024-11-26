import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late TextEditingController _controller;
  String _query = '';
  List<String> recentSearches = ['Genesis 1', 'John 3:16', 'Psalms 23'];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
    _query = widget.query;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      _query = _controller.text;
    });
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      _query = '';
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: TextField(
            controller: _controller,
            autofocus: true,
            onChanged: (value) {
              setState(() => _query = value);
            },
            onSubmitted: (_) => _search(),
            decoration: InputDecoration(
              hintText: 'Search for verses, books, or keywords...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.deepPurpleAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: _clearSearch,
                    ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.deepPurpleAccent),
                    onPressed: _search,
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
      child: _query.isEmpty
          ? _buildInitialContent()
          : FutureBuilder<List<Map<String, dynamic>>>(
              future: _searchInDatabase(_query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No results found.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                } else {
                  final results = snapshot.data!;
                  return _buildResultsList(results);
                }
              },
            ),
    ),
  );
}

  Widget _buildInitialContent() {
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
          children: recentSearches
              .map((search) => ActionChip(
                    label: Text(search),
                    onPressed: () {
                      setState(() {
                        _controller.text = search;
                        _query = search;
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildResultsList(List<Map<String, dynamic>> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent.withOpacity(0.2),
              child: Icon(Icons.book, color: Colors.deepPurpleAccent),
            ),
            title: Text(
              result['text'],
              style: TextStyle(
                fontSize: _getFontSize(context),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            subtitle: Text(
              '${result['book']} ${result['chapter']}:${result['verse']}',
              style: TextStyle(
                fontSize: _getFontSize(context) - 2,
                color: Colors.deepPurpleAccent,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.bookmark_border, color: Colors.deepPurpleAccent),
                  onPressed: () {
                    // Implement bookmark toggle logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.deepPurpleAccent),
                  onPressed: () {
                    // Implement share functionality
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _getFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return 14;
    } else if (screenWidth < 1200) {
      return 16;
    } else {
      return 18;
    }
  }

  Future<List<Map<String, dynamic>>> _searchInDatabase(String query) async {
    await Future.delayed(const Duration(milliseconds: 800));

    List<Map<String, dynamic>> bibleData = [
      {'text': 'In the beginning...', 'book': 'Genesis', 'chapter': 1, 'verse': 1},
      {'text': 'God said, Let there be light.', 'book': 'Genesis', 'chapter': 1, 'verse': 3},
      {'text': 'The Lord is my shepherd.', 'book': 'Psalms', 'chapter': 23, 'verse': 1},
      {'text': 'For God so loved the world...', 'book': 'John', 'chapter': 3, 'verse': 16},
    ];

    return bibleData.where((verse) {
      String fullText = '${verse['text']} ${verse['book']} ${verse['chapter']} ${verse['verse']}';
      return fullText.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
