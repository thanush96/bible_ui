import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

class ChapVerseLoader extends StatelessWidget {
  final ScrollController? scrollController; // Optional ScrollController

  const ChapVerseLoader({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          controller: scrollController, // Attach ScrollController here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVerseSkeleton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerseSkeleton(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            20,
            (index) => Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
