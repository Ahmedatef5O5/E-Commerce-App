import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/custome_product_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartProduct});
  final AddToCartModel cartProduct;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 12, left: 14),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.greyWithShade,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CachedNetworkImage(
                imageUrl: cartProduct.product.imgUrl,
                width: 90,
                height: 100,
                placeholder: (context, url) => Center(
                  child: Center(
                    child: CupertinoActivityIndicator(color: Colors.black12),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Center(child: const Icon(Icons.error, color: Colors.red)),
              ),
            ),
          ),
          Gap(7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartProduct.product.name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                Gap(8),
                Text.rich(
                  TextSpan(
                    text: 'Size:\t\t',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: cartProduct.size.name,
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 35,
                      width: 110,
                      child: CustomProductCounter(
                        quantity: cartProduct.quantity,
                        productId: cartProduct.id,
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.bottom,
                            child: Transform.translate(
                              offset: const Offset(-2, -12),
                              child: Text(
                                '\$',
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '${cartProduct.product.price}',
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26,
                                ),
                          ),
                        ],
                      ),
                    ),

                    // Text(
                    //   '\$${cartProduct.product.price}',
                    //   style: Theme.of(context).textTheme.headlineMedium!
                    //       .copyWith(fontWeight: FontWeight.w700, fontSize: 26),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
