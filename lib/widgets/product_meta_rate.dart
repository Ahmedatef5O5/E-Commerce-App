import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductRateMeta extends StatelessWidget {
  const ProductRateMeta({super.key, required this.averegeRate});

  final String averegeRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.star_rate, color: Colors.amber, size: 22),
        Gap(3),
        Text(
          averegeRate,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(3),
        Text(
          '(320 Review)',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: Colors.grey.shade500),
        ),
        Spacer(),
        Text(
          'Avaliable in stock',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
