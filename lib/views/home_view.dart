import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/header_home_section.dart';
import '../widgets/main_tab_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: Scaffold(
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
      ),
    );
  }
}
