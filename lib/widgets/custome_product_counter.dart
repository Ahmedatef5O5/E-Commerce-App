import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utilities/app_colors.dart';

class CustomProductCounter extends StatelessWidget {
  const CustomProductCounter({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.padding,
  });
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 42,
      // width: 128,
      decoration: BoxDecoration(
        color: AppColors.greyWithShade,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20),
          left: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding:
            padding ??
            const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.whiteColor,
              child: InkWell(
                onTap: onDecrement,
                child: Icon(
                  Icons.remove,
                  color: quantity <= 1 ? Colors.black38 : Colors.black,
                  size: 21,
                ),
              ),
            ),
            Gap(10),
            Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(10),
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.whiteColor,
              child: InkWell(
                onTap: onIncrement,
                child: Icon(Icons.add, color: Colors.black, size: 21),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
