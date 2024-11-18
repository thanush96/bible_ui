import 'package:flutter/material.dart';

class AudioPlayer extends StatelessWidget {
  final bool isExpanded;
  final String chapterTitle;
  final String verseExcerpt;
  final double progress;
  final VoidCallback onClose;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;
  final bool isPlaying;

  const AudioPlayer({
    Key? key,
    this.isExpanded = false,
    required this.chapterTitle,
    required this.verseExcerpt,
    required this.progress,
    required this.onClose,
    required this.onPrevious,
    required this.onNext,
    required this.onPlayPause,
    required this.isPlaying,
  }) : super(key: key);

  get playerStateStream => null;

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade900],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: SliderComponentShape.noThumb,
                  overlayShape: SliderComponentShape.noOverlay,
                  trackHeight: 2.0,
                ),
                child: Slider(
                  value: progress,
                  onChanged: (value) {},
                  activeColor: Colors.white,
                  inactiveColor: Colors.white24,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: onPlayPause,
            ),
          ],
        ),
      );
    }

    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade900],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      chapterTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      verseExcerpt,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: onClose,
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                onPressed: onPrevious,
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 48,
                ),
                onPressed: onPlayPause,
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                onPressed: onNext,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "4:95",
                  style: TextStyle(color: Colors.white70),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.0,
                    ),
                    child: Slider(
                      value: progress,
                      onChanged: (value) {},
                      activeColor: Colors.white,
                      inactiveColor: Colors.white24,
                    ),
                  ),
                ),
                const Text(
                  "5:25",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
