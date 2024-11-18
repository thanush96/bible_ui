import 'package:flutter/material.dart';

class CustomHeader extends StatefulWidget {
  final VoidCallback onBackPressed;

  const CustomHeader({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBackPressed,
              ),
              // Using AnimatedSwitcher for smooth transition between widgets
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(
                      milliseconds: 300), // Adjust duration for the transition
                  child: isSearchVisible
                      ? TextField(
                          key: ValueKey('searchField'),
                          style: const TextStyle(fontFamily: 'Times'
                              // fontWeight: FontWeight.w500,
                              ),
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
                        )
                      : null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                // icon: Icon(isSearchVisible ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    isSearchVisible = !isSearchVisible;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
