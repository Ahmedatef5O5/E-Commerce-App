import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class AddToCartSection extends StatelessWidget {
  const AddToCartSection({super.key, required this.price});
  final double price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              text: ('\$'),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
              ),

              children: [
                TextSpan(
                  text: price.toString(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 30,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 55,
            width: 180,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                // backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
              ),
              onPressed: () {},
              label: Text(
                'Add to Cart',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor),
              ),
              icon: Icon(Icons.shopping_bag_outlined, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
