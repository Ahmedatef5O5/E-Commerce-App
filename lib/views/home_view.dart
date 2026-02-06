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
              HeaderHomeSection(),
              Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('Home'), Text('Category')],
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
