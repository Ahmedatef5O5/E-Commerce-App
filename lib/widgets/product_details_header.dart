import 'package:ecommerce_app/widgets/product_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({super.key, required this.productName});

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productName,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            ProductCounter(),
          ],
        ),
      ],
    );
  }
}
