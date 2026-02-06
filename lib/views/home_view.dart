import 'package:ecommerce_app/widgets/category_tab_view.dart';
import 'package:ecommerce_app/widgets/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/header_home_section.dart';
import '../widgets/main_tab_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
            MainTabBar(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [HomeTabView(), CategoryTabView()],
              ),
            ),
            Gap(12),
          ],
        ),
      ),
    );
  }
}
