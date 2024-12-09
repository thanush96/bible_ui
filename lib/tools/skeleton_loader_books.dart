import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

class SkeletonLoaderBooks extends StatelessWidget {
  const SkeletonLoaderBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  8, (index) => _buildVerseSkeleton(index, context)),
            ),
          ],
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
}
