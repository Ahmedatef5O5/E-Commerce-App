import 'package:flutter/material.dart';

class CheckoutHeadline extends StatelessWidget {
  const CheckoutHeadline({
    super.key,
    required this.title,
    this.numOfProducts,
    this.onTap,
  });
  final String title;
  final int? numOfProducts;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        if (numOfProducts != null)
          Text(
            '($numOfProducts)',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              'Edit',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
