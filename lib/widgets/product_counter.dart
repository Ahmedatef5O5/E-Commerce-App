import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utilities/app_colors.dart';

class ProductCounter extends StatelessWidget {
  const ProductCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.greyWithShade,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20),
          left: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              child: Icon(Icons.remove, color: Colors.black, size: 22),
            ),
            Gap(10),
            Text(
              '1',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(10),
            CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              child: Icon(Icons.add, color: Colors.black, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
