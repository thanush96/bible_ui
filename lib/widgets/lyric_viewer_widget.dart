import 'dart:async';
import 'package:flutter/material.dart';

class LyricsWidget extends StatefulWidget {
  final String text; // Input text for lyrics
  final int duration; // Total duration in seconds

  const LyricsWidget({
    super.key,
    required this.text,
    required this.duration,
  });

  @override
  State<LyricsWidget> createState() => _LyricsWidgetState();
}

class _LyricsWidgetState extends State<LyricsWidget>
    with SingleTickerProviderStateMixin {
  late List<String> lyrics; // Split text into manageable lines
  int currentLineIndex = 0; // Tracks the current displayed line
  Timer? _timer; // Timer for auto display
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    lyrics = _splitText(widget.text); // Use text from the widget
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Define scale and opacity animations
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _startLyricPlayback();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<String> _splitText(String text) {
    // Split text by periods (.) and commas (,), then trim extra spaces
    return text
        .split(RegExp(r'[.,]'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  void _startLyricPlayback() {
    final int interval =
        (widget.duration / lyrics.length).floor(); // Seconds per line
    _timer = Timer.periodic(Duration(seconds: interval), (timer) {
      if (currentLineIndex < lyrics.length - 1) {
        setState(() {
          currentLineIndex++;
        });
        _animationController.forward(from: 0.0);

        // Smooth scroll to ensure the current line is centered
        _scrollController.animateTo(
          currentLineIndex * 60.0 - MediaQuery.of(context).size.height / 2 + 30,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      } else {
        _timer?.cancel(); // Stop when all lines are displayed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lyrics.length,
                itemBuilder: (context, index) {
                  final isCurrentLine = index == currentLineIndex;
                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: isCurrentLine ? 12.0 : 10.0,
                        ),
                        child: Transform.scale(
                          scale: isCurrentLine ? _scaleAnimation.value : 1.0,
                          child: Opacity(
                            opacity:
                                isCurrentLine ? _opacityAnimation.value : 0.4,
                            child: Text(
                              lyrics[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isCurrentLine ? 20 : 16,
                                fontWeight: isCurrentLine
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isCurrentLine
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 50), // Extra space
          ],
        ),
      ),
    );
  }
}
