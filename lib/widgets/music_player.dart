import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:just_audio/just_audio.dart';

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
    return Container(
      height: 230,
      margin: const EdgeInsets.all(20),
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
          // Close button
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chapter ${widget.chapterID}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '"${widget.content} ..."',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                // Control buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // IconButton(
                    //   icon: const Icon(Icons.skip_previous,
                    //       color: Colors.white, size: 32),
                    //   onPressed:
                    //       isLoading ? null : () {}, // Implement skip logic
                    // ),
                    // IconButton(
                    //   icon: const Icon(Icons.arrow_back_ios_rounded,
                    //       color: Colors.white, size: 22),
                    //   onPressed:
                    //       isLoading ? null : () {}, // Implement rewind logic
                    // ),
                    GestureDetector(
                      onTap: _playPauseAudio,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _playPauseController,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.arrow_forward_ios_rounded,
                    //       color: Colors.white, size: 22),
                    //   onPressed: isLoading
                    //       ? null
                    //       : () {}, // Implement fast-forward logic
                    // ),
                    // IconButton(
                    //   icon: const Icon(Icons.skip_next,
                    //       color: Colors.white, size: 32),
                    //   onPressed:
                    //       isLoading ? null : () {}, // Implement skip logic
                    // ),
                  ],
                ),
                const SizedBox(height: 15),
                // Time Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_currentPosition),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      _formatDuration(_totalDuration),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                    thumbColor: Colors.white,
                    trackHeight: 2.0,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                  ),
                  child: Slider(
                    value: _currentPosition.inMilliseconds >
                            _totalDuration.inMilliseconds
                        ? _totalDuration.inMilliseconds.toDouble()
                        : _currentPosition.inMilliseconds.toDouble(),
                    min: 0,
                    max: _totalDuration.inMilliseconds.toDouble(),
                    onChanged: (value) async {
                      final newPosition = Duration(milliseconds: value.toInt());
                      await _audioPlayer.seek(newPosition);
                    },
                  ),
                ),
                // const SizedBox(height: 10),
                // Time Progress
                // if (isPlaying)
                //   if (_totalDuration.inMilliseconds > 0)
                //     SliderTheme(
                //       data: SliderTheme.of(context).copyWith(
                //         activeTrackColor: Colors.white,
                //         inactiveTrackColor: Colors.white.withOpacity(0.3),
                //         thumbColor: Colors.white,
                //         trackHeight: 2.0,
                //       ),
                //       child: Slider(
                //         value: _currentPosition.inMilliseconds.toDouble(),
                //         min: 0,
                //         max: _totalDuration.inMilliseconds.toDouble(),
                //         onChanged: (value) {
                //           setState(() {
                //             _audioPlayer
                //                 .seek(Duration(milliseconds: value.toInt()));
                //           });
                //         },
                //       ),
                //     ),
                // if (isLoading)
                //   const Center(
                //     child: CircularProgressIndicator(
                //       color: Colors.white,
                //       strokeWidth: 2.0,
                //     ),
                //   ),
              ],
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
