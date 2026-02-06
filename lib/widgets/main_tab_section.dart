import 'package:ecommerce_app/widgets/category_tab_view.dart';
import 'package:ecommerce_app/widgets/home_tab_view.dart';
import 'package:flutter/material.dart';

class MainTabSection extends StatefulWidget {
  const MainTabSection({super.key});

  @override
  State<MainTabSection> createState() => _MainTabSectionState();
}

class _MainTabSectionState extends State<MainTabSection>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
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
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [HomeTabView(), CategoryTabView()],
            ),
          ),
        ],
      ),
    );
  }
}
