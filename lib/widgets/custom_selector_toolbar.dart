import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  final Function(String, String) onAddToFavorite;
  final Function(String) onHighlight;

  CustomTextSelectionControls(
      {required this.onAddToFavorite, required this.onHighlight});

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final String selectedText = delegate.textEditingValue.selection.textInside(
      delegate.textEditingValue.text,
    );

    // If there is no selection, return an empty toolbar
    if (endpoints.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get the endpoint for the end of the selection
    final TextSelectionPoint lastEndpoint = endpoints.last;
    final Offset selectionEnd = lastEndpoint.point;

    // Define the custom toolbar button
    final toolbarItems = [
      TextSelectionToolbarTextButton(
        onPressed: () {
          // Custom action for "Add to Fav"

          String id = DateTime.now().millisecondsSinceEpoch.toString();
          String title = "Chapter ${id.substring(id.length - 2)}";
          onAddToFavorite(id, title);

          print(title);

          delegate.hideToolbar(); // Hide the toolbar after the action
        },
        padding: const EdgeInsets.all(8.0), // Add padding here
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, color: Colors.black, size: 18), // Add an icon
            SizedBox(width: 4), // Add spacing between icon and text
            Text('Add to Fav',
                style: TextStyle(fontSize: 16)), // Add custom text style
          ],
        ),
      ),
      TextSelectionToolbarTextButton(
        onPressed: () {
          // Custom action for "Add to Fav"
          print("highlight");
          print(selectedText);

          if (onHighlight != null && selectedText.isNotEmpty) {
            onHighlight!(
                selectedText); // Trigger the callback with selected text
          }
          delegate.hideToolbar(); // Hide the toolbar after the action
        },
        padding: const EdgeInsets.all(8.0), // Add padding here
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.colorize, color: Colors.black, size: 18), // Add an icon
            SizedBox(width: 4), // Add spacing between icon and text
            Text('highlight',
                style: TextStyle(fontSize: 16)), // Add custom text style
          ],
        ),
      ),
    ];

    // Return the custom toolbar anchored at the end of the selection
    return TextSelectionToolbar(
      anchorAbove: selectionEnd, // Position at the end of the selection
      anchorBelow: selectionEnd, // Position at the end of the selection
      children: toolbarItems,
    );
  }
}
