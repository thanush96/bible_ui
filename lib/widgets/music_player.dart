import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:just_audio/just_audio.dart';
import 'lyric_viewer_widget.dart';

class PopupMusicPlayer extends StatefulWidget {
  final String? audioFilePath;
  final String? chapterID;
  final String? content;
  const PopupMusicPlayer({
    super.key,
    this.audioFilePath,
    this.chapterID,
    this.content,
  });

  @override
  _PopupMusicPlayerState createState() => _PopupMusicPlayerState();
}

class _PopupMusicPlayerState extends State<PopupMusicPlayer>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Sample audio file URL
  final String _sampleAudio = "assets/audio/bible.mp3";

  bool isPlaying = false;
  bool isLoading = true;

  late AnimationController _playPauseController;

  @override
  void initState() {
    super.initState();

    _playPauseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Listen to the duration of the audio
    _audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _totalDuration = duration ?? Duration.zero;
        });
      }
    });

    // Listen to the current position of the audio
    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    // When audio completes, reset and stop
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (mounted) {
          setState(() {
            isPlaying = false;
            _playPauseController.reverse();
            _currentPosition = Duration.zero;
          });
        }
      }
    });
  }

  void _playPauseAudio() async {
    if (isPlaying) {
      // Pause the audio
      _playPauseController.reverse();
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      // Reset to the beginning if audio is completed
      if (_audioPlayer.processingState == ProcessingState.completed) {
        await _audioPlayer.seek(Duration.zero); // Reset to the start
      }

      // Play the audio
      try {
        if (_audioPlayer.processingState == ProcessingState.idle) {
          await _audioPlayer
              .setFilePath(widget.audioFilePath ?? "assets/audio/bible.mp3");
        }
        _playPauseController.forward();
        setState(() {
          isPlaying = true;
        });
        await _audioPlayer.play();
      } catch (e) {
        debugPrint("Error playing audio: $e");
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _playPauseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String lyrics =
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, comes from a line The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.";

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: globalGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          const LyricsWidget(text: lyrics, duration: 60),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Content
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Adjust the radius as needed
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Chapter ${widget.chapterID}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 180, 180, 180),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Control buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _playPauseAudio,
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _playPauseController,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 15),
                    // Time Progress
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_currentPosition),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          _formatDuration(_totalDuration),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white.withOpacity(0.3),
                        thumbColor: Colors.white,
                        trackHeight: 2.0,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8.0),
                      ),
                      child: Slider(
                        value: _currentPosition.inMilliseconds >
                                _totalDuration.inMilliseconds
                            ? _totalDuration.inMilliseconds.toDouble()
                            : _currentPosition.inMilliseconds.toDouble(),
                        min: 0,
                        max: _totalDuration.inMilliseconds.toDouble(),
                        onChanged: (value) async {
                          final newPosition =
                              Duration(milliseconds: value.toInt());
                          await _audioPlayer.seek(newPosition);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
