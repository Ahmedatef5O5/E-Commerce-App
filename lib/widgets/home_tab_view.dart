import 'package:ecommerce_app/widgets/home_carousel_slider.dart';
import 'package:ecommerce_app/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [Gap(16), HomeCarouselSlider(), Gap(16), ProductGridView()],
      ),
    );
  }
}
