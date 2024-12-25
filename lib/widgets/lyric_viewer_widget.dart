import 'dart:async';
import 'package:flutter/material.dart';

class LyricsWidget extends StatefulWidget {
  final String text; // Input text for lyrics
  final int duration; // Total duration in seconds
  final bool isPlaying;

  const LyricsWidget({
    super.key,
    required this.text,
    required this.duration,
    required this.isPlaying,
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
    lyrics = splitByVerseNumbers(widget.text); // Use text from the widget
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Define scale and opacity animations
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(0);
    });

    if (widget.isPlaying) {
      _startLyricPlayback();
    }
  }

  @override
  void didUpdateWidget(LyricsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _resumePlayback();
      } else {
        _pausePlayback();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<String> splitByVerseNumbers(String text) {
    // Regular expression to match verse numbers like [1], [2], etc.
    RegExp verseRegex = RegExp(r'\[\d+\]');

    // Split text by verse numbers while keeping the numbers as part of each segment
    Iterable<Match> matches = verseRegex.allMatches(text);

    List<String> verses = [];
    int previousIndex = 0;

    for (final match in matches) {
      if (match.start > previousIndex) {
        // Add the text before the current verse number
        verses.add(text.substring(previousIndex, match.start).trim());
      }
      previousIndex = match.start;
    }

    // Add the last section of text
    if (previousIndex < text.length) {
      verses.add(text.substring(previousIndex).trim());
    }

    // Return the cleaned-up list of verses
    return verses.where((verse) => verse.isNotEmpty).toList();
  }

  void _startLyricPlayback() {
    if (lyrics.isEmpty) return;

    final int interval = (widget.duration / lyrics.length).floor();

    _timer = Timer.periodic(Duration(seconds: interval), (timer) {
      if (currentLineIndex < lyrics.length - 1) {
        setState(() {
          currentLineIndex++;
        });

        // Update animation duration based on line length
        _setAnimationDurationBasedOnLetters(lyrics[currentLineIndex]);

        _animationController.forward(from: 0.0);

        // Calculate the offset for centering the current line
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final viewportHeight = renderBox.size.height;

          const lineHeight = 80.0; // Approximate height of a single line
          final centerOffset = (currentLineIndex * lineHeight) -
              (viewportHeight / 2) +
              (lineHeight / 2);

          // Ensure the offset remains within scrollable bounds
          final maxScrollOffset = _scrollController.position.maxScrollExtent;
          final safeOffset = centerOffset.clamp(0, maxScrollOffset);

          _scrollController.animateTo(
            safeOffset.toDouble(), // Adjust to safe offset
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      } else {
        _timer?.cancel();
      }
    });
  }

// Helper function to set animation duration dynamically
  void _setAnimationDurationBasedOnLetters(String line) {
    const int timePerLetterMs = 20; // Define time per letter in milliseconds
    const int timePerLineMs = 20; // Extra time per visual line

    // Calculate visual lines
    int visualLines = _calculateVisualLines(line);

    // Calculate total duration
    final int calculatedDuration =
        (line.length * timePerLetterMs) + (visualLines * timePerLineMs);

    // Set the new animation duration
    _animationController.duration = Duration(milliseconds: calculatedDuration);
  }

// Helper function to calculate the number of visual lines a text occupies
  int _calculateVisualLines(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 12), // Use the current font size
      ),
      maxLines: null, // Allow text to wrap
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 28); // Adjust width

    // Calculate the number of visual lines based on height and font size
    return (textPainter.height / textPainter.preferredLineHeight).ceil();
  }

  void _pausePlayback() {
    _timer?.cancel();
    _animationController.stop();
  }

  void _resumePlayback() {
    _startLyricPlayback();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 10),
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
                                fontSize: isCurrentLine ? 16 : 12,
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
