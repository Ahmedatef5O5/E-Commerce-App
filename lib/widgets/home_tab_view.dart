import 'package:ecommerce_app/widgets/home_carousel_slider.dart';
import 'package:ecommerce_app/widgets/product_grid_view_sliver.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Gap(16)),
        SliverToBoxAdapter(child: HomeCarouselSlider()),
        SliverToBoxAdapter(child: Gap(16)),
        ProductGridViewSliver(),
      ],
    );
  }
}
