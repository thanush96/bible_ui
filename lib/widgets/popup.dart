import 'package:flutter/material.dart';

class VideoQuality {
  final String label;
  final String resolution;

  VideoQuality({required this.label, required this.resolution});
}

class VideoQualityPicker extends StatelessWidget {
  final List<VideoQuality> availableQualities;
  final ValueChanged<VideoQuality> onQualitySelected;

  const VideoQualityPicker({
    Key? key,
    required this.availableQualities,
    required this.onQualitySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Video Quality'),
      content: ListView.builder(
        itemCount: availableQualities.length,
        itemBuilder: (BuildContext context, int index) {
          VideoQuality quality = availableQualities[index];
          return ListTile(
            title: Text(quality.label),
            onTap: () {
              onQualitySelected(quality);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
