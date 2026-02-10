import 'package:ecommerce_app/cubit/Cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/cubit/Product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartSection extends StatelessWidget {
  const AddToCartSection({
    super.key,
    required this.price,
    required this.productId,
  });
  final double price;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
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
          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                current is ProductAddingToCart || current is ProductAddedToCart,
            builder: (context, state) {
              if (state is ProductAddingToCart) {
                return SizedBox(
                  height: 55,
                  width: 175,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyWithShade,
                      // backgroundColor: AppColors.primaryColor,
                      // foregroundColor: AppColors.blackColor,
                    ),
                    onPressed: null,
                    child: Center(
                      child: CupertinoActivityIndicator(color: Colors.black12),
                    ),
                  ),
                );
              } else if (state is ProductAddedToCart) {
                return SizedBox(
                  height: 55,
                  width: 175,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyWithShade,
                      // backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.black26,
                    ),
                    onPressed: null,
                    child: Center(
                      child: Text(
                        'Added to Cart',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Colors.black45),
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 55,
                  width: 175,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      // backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      if (cubit.selectedSize != null) {
                        final newItem = cubit.addToCart(productId);
                        if (newItem != null) {
                          context.read<CartCubit>().addProductToCart(newItem);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select size')),
                        );
                      }
                    },
                    label: Text(
                      'Add to Cart',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    icon: Icon(Icons.shopping_bag_outlined, size: 22),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
