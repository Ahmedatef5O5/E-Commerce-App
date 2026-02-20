import 'package:ecommerce_app/cubit/Product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
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
                return CustomElevatedButton(
                  width: 172,
                  height: 50,
                  backgroundColor: AppColors.greyWithShade,
                  onPressed: null,
                  child: Center(
                    child: CupertinoActivityIndicator(color: Colors.black12),
                  ),
                );
              } else if (state is ProductAddedToCart) {
                return CustomElevatedButton(
                  width: 165,
                  height: 50,
                  backgroundColor: AppColors.greyWithShade,
                  foregroundColor: Colors.black26,
                  onPressed: null,
                  child: Text('Added to Cart'),
                );
              } else {
                return CustomElevatedButton(
                  width: 172,
                  height: 50,
                  leadingIcon: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () async {
                    if (cubit.selectedSize != null) {
                      await cubit.addToCart(productId);
                      // final newItem = cubit.addToCart(productId);
                      // if (newItem != null) {
                      //   context.read<CartCubit>().addProductToCart(newItem);
                      // }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select size')),
                      );
                    }
                  },
                  child: Text('Add to Cart'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
