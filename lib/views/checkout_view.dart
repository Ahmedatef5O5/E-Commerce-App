import 'package:ecommerce_app/widgets/checkout_head_line.dart';
import 'package:ecommerce_app/widgets/custom_add_container.dart';
import 'package:ecommerce_app/widgets/price_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 24),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Payment',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CheckoutHeadline(title: 'Address', onTap: () {}),
              Gap(10),
              CustomAddContainer(title: 'Add Shiping address'),
              Gap(10),
              CheckoutHeadline(title: 'Products', onTap: null),
              Gap(200),
              CheckoutHeadline(title: 'Payment Methods', onTap: null),
              Gap(10),
              CustomAddContainer(title: 'Add Payment method'),
              Gap(25),
              PriceRow(label: 'Total Amount', value: 12),
              Gap(25),
              ElevatedButton(
                onPressed: () {},
                // onPressed: () => Navigator.of(
                //   context,
                //   rootNavigator: true,
                // ).pushNamed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff514eb7),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Proceed to Buy',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
