import 'package:flutter/material.dart';
import '../screens/results/search_results_page.dart';

class CustomHeader extends StatefulWidget {
  final VoidCallback onBackPressed;

  const CustomHeader({
    super.key,
    required this.onBackPressed,
  });

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    final query = _searchController.text.trim();
    debugPrint('Search $query');

    if (query.isNotEmpty) {
      debugPrint('Performing search with query: $query');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(
            initialQuery: query,
          ),
        ),
      );
    } else {
      debugPrint('Search query is empty $query');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Second Row: Main Content
        Container(
          height: 60, // Provide a fixed height
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBackPressed,
              ),

              // Animated Search Box
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isSearchVisible
                    ? MediaQuery.of(context).size.width * 0.7
                    : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 30),
                    child: Opacity(
                      opacity: isSearchVisible ? 1.0 : 0.0,
                      child: TextField(
                        controller: _searchController,
                        key: ValueKey('searchField'),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearchVisible = !isSearchVisible;
                  });
                  if (!isSearchVisible) {
                    _search();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
