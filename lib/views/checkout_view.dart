import 'package:ecommerce_app/widgets/checkout_head_line.dart';
import 'package:flutter/material.dart';

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
          child: Column(children: [CheckoutHeadline(title: 'Address')]),
        ),
      ),
    );
  }
}
