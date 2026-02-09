import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyCartState extends StatelessWidget {
  const EmptyCartState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(45),
        Image.asset(
          AppImages.emptyCart,
          width: 280,
          height: 300,
          fit: BoxFit.contain,
        ),
        Gap(30),
        Center(
          child: Text(
            'No items in your cart !',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.grey.shade600,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
