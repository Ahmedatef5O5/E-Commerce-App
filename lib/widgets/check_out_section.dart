import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/price_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:gap/gap.dart';

class CheckOutSection extends StatelessWidget {
  const CheckOutSection({super.key, required this.subtotal});
  final double shipping = 6.00;
  final double subtotal;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              thickness: 5,
              color: Colors.black12,
              indent: 140,
              endIndent: 140,
              // radius: BorderRadius.vertical(top: Radius.circular(50)),
              radius: BorderRadius.horizontal(
                left: Radius.circular(50),
                right: Radius.circular(50),
              ),
            ),
            // const Gap(20),
            // Container(
            //   height: 46,
            //   width: constraints.maxWidth,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: Colors.blueGrey.shade100, width: 1.2),
            //     color: Colors.grey[200],
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Gap(10),
            //         Image.asset(
            //           AppImages.promoCode,
            //           width: 22,
            //           height: 20,
            //           color: Colors.blueGrey.shade200,
            //         ),
            //         Gap(14),
            //         Text(
            //           'Enter your promo code',
            //           style: Theme.of(context).textTheme.labelLarge!.copyWith(
            //             color: Colors.black26,
            //             fontWeight: FontWeight.w500,
            //             fontSize: 16,
            //           ),
            //         ),
            //         Spacer(),
            //         Icon(
            //           Icons.arrow_forward_ios_outlined,
            //           color: Colors.black26,
            //         ),
            //         Gap(6),
            //       ],
            //     ),
            //   ),
            // ),
            // const Gap(20),
            PriceRow(label: 'Subtotal', value: subtotal),
            const Gap(14),
            PriceRow(label: 'Shipping', value: shipping),
            const Gap(18),
            Dash(
              length: constraints.maxWidth,
              dashGap: 6,
              direction: Axis.horizontal,
              dashLength: 15,
              dashColor: AppColors.blueGreyWithShade,
            ),
            const Gap(18),
            PriceRow(label: 'Total amount', value: subtotal + shipping),
            const Gap(18),
            ElevatedButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(AppRoutes.checkoutViewRoute),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff514eb7),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
