import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/product_details_header.dart';
import 'package:ecommerce_app/widgets/product_meta_rate.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.productName,
    required this.averegeRate,
    required this.quantity,
    required this.productId,
  });
  final String productName, averegeRate;
  final int quantity;
  final String productId;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.25,
      maxChildSize: 0.68,
      expand: false,
      shouldCloseOnMinExtent: false,
      builder: (BuildContext context, ScrollController scrollController) =>
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                Gap(14),
                Divider(
                  thickness: 7,
                  color: AppColors.bgProductDetailsColor,
                  indent: 170,
                  endIndent: 170,
                  // radius: BorderRadius.vertical(top: Radius.circular(50)),
                  radius: BorderRadius.horizontal(
                    left: Radius.circular(50),
                    right: Radius.circular(50),
                  ),
                ),
                Gap(8),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductDetailsHeader(
                              productName: productName,
                              quantity: quantity,
                              productId: productId,
                            ),
                            Gap(8),
                            ProductRateMeta(averegeRate: averegeRate),

                            //
                            Gap(70),
                            Text('data'),
                            Gap(70),
                            Text('data'),
                            Gap(70),
                            Text('data'),
                            Gap(70),
                            Text('data'),
                            Gap(70),
                            Text('data'),
                            Gap(70),
                            Text('data'),
                            Gap(70),
                            Text('data'),
                            Gap(70),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
