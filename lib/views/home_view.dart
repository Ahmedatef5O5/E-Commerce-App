import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/header_home_section.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/product_grid_view.dart';

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
              HomeCarouselSlider(),
              Gap(16),
              ProductGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
