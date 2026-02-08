import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DescriptionProductSection extends StatelessWidget {
  const DescriptionProductSection({
    super.key,
    required this.productDescription,
  });

  final String productDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(4),
        Text(
          productDescription,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 12,
            color: Colors.black45,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
