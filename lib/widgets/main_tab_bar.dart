import 'package:flutter/material.dart';

class MainTabBar extends StatelessWidget {
  const MainTabBar({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).primaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 42),
      indicatorWeight: 2,
      dividerColor: Colors.transparent,
      unselectedLabelColor: Colors.grey.shade500,
      labelStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      tabs: [
        Tab(text: 'Home'),
        Tab(text: 'Category'),
      ],
    );
  }
}
