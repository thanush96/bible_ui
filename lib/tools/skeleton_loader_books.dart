import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

class SkeletonLoaderBooks extends StatelessWidget {
  final int count;
  final bool inCludeBook;
  final bool inCludeRound;
  final bool inCludeText;

  const SkeletonLoaderBooks(
      {super.key,
      this.count = 8,
      this.inCludeBook = true,
      this.inCludeRound = false,
      this.inCludeText = true});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: inCludeBook,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                ),
              ),
              Visibility(
                visible: inCludeText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      count, (index) => _buildVerseSkeleton(index, context)),
                ),
              ),
              Visibility(
                  visible: inCludeRound,
                  child: Column(
                    children: [
                      _buildRoundSkeletonRow(context),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRoundSkeletonRow(BuildContext context) {
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

Widget _buildVerseSkeleton(int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                color: Colors.white,
              ),
              if (index % 2 == 0) ...[
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: MediaQuery.of(context).size.width * 0.4,
                  color: Colors.white,
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
