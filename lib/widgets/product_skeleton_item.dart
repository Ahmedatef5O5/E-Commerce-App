import 'package:flutter/material.dart';

class ProductSkeletonItem extends StatelessWidget {
  const ProductSkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: 190,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 14, width: 120, color: Colors.grey.shade300),
        const SizedBox(height: 6),
        Container(height: 12, width: 80, color: Colors.grey.shade200),
        const SizedBox(height: 6),
        Container(height: 14, width: 50, color: Colors.grey.shade300),
      ],
    );
  }
}
