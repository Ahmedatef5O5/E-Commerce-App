import 'package:ecommerce_app/widgets/category_tab_view.dart';
import 'package:ecommerce_app/widgets/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/header_home_section.dart';
import '../widgets/main_tab_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Gap(12),
            HeaderHomeSection(),
            Gap(12),
            MainTabSection(),
            Gap(12),
          ],
        ),
      ),
    );
  }
}
