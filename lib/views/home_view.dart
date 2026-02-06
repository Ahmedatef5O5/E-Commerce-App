import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../models/product_item_model.dart';
import '../widgets/header_home_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: HeaderHomeSection(),
              ),
              Gap(12),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 0.8,
                ),
                itemCount: dummyProducts.length,
                itemBuilder: (BuildContext context, int index) =>
                    ProductItem(productItem: dummyProducts[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
