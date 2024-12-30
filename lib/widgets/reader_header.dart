import 'package:flutter/material.dart';

class ReaderHeader extends StatefulWidget {
  final VoidCallback onBackPressed;
  final bool isPlaying;
  final VoidCallback onPlayOpen;

  const ReaderHeader({
    super.key,
    required this.onBackPressed,
    required this.isPlaying,
    required this.onPlayOpen,
  });

  @override
  State<ReaderHeader> createState() => _ReaderHeaderState();
}

class _ReaderHeaderState extends State<ReaderHeader> {
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Shrink-wrap the content
      children: [
        // First Row: Profile Icon
        Container(
          padding: const EdgeInsets.fromLTRB(0, 30, 15, 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.person,
                size: 30,
              ),
            ],
          ),
        ),
        // Second Row: Main Content
        Container(
          height: 60, // Provide a fixed height
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBackPressed,
              ),
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: widget.onPlayOpen,
              ),
              SizedBox(
                height: 30,
                child: Image.asset('assets/waw.png'),
              ),
              const SizedBox(
                width: 05,
              ),
              // Animated Search Box
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 145, 189, 223),
                      Color(0xFFE0E0E0)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                curve: Curves.easeInOut,
                width: isSearchVisible
                    ? MediaQuery.of(context).size.width - 200
                    : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: Opacity(
                      opacity: isSearchVisible ? 1.0 : 0.0,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
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
                icon: Icon(isSearchVisible ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    isSearchVisible = !isSearchVisible;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
