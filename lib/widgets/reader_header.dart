import 'package:flutter/material.dart';

class ReaderHeader extends StatefulWidget {
  final VoidCallback onBackPressed;
  final bool isPlaying;
  final VoidCallback onPlayOpen;

  const ReaderHeader({
    Key? key,
    required this.onBackPressed,
    required this.isPlaying,
    required this.onPlayOpen,
  }) : super(key: key);

  @override
  State<ReaderHeader> createState() => _ReaderHeaderState();
}

class _ReaderHeaderState extends State<ReaderHeader> {
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => Container(
                  width: 2,
                  height: (index + 1) * 5.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          if (isSearchVisible)
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            )
          else
            const Spacer(),
          IconButton(
            icon: Icon(isSearchVisible ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearchVisible = !isSearchVisible;
              });
            },
          ),
          // const CircleAvatar(
          //   radius: 15,
          //   backgroundImage: AssetImage('assets/profile.png'),
          // ),
        ],
      ),
    );
  }
}
