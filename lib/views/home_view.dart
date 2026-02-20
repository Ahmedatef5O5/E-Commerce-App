import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/main_tab_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [MainTabSection(), Gap(12)],
        ),
      ),
    );
  }
}
