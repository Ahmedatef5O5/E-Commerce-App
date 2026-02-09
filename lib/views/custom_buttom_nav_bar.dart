import 'package:ecommerce_app/cubit/Cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/views/favorite_view.dart';
import 'package:ecommerce_app/views/home_view.dart';
import 'package:ecommerce_app/views/order_view.dart';
import 'package:ecommerce_app/views/profile_view.dart';
import 'package:ecommerce_app/widgets/custom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomButtomNavbar extends StatefulWidget {
  const CustomButtomNavbar({super.key});

  @override
  State<CustomButtomNavbar> createState() => _CustomButtomNavbarState();
}

class _CustomButtomNavbarState extends State<CustomButtomNavbar> {
  late final PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(); //initialIndex: 0 by default
  }

  List<Widget> _screens(BuildContext context) {
    return [
      HomeView(),
      BlocProvider(
        create: (BuildContext context) {
          final cubit = CartCubit();
          cubit.getCartItem();
          return cubit;
        },
        child: const OrderView(),
      ),
      FavoriteView(),
      ProfileView(),
    ];
  }

  List<ItemConfig> _navBarsItems() {
    return [
      CustomNavItem.build(
        context: context,
        iconPath: AppImages.home,
        title: "Home",
      ),
      CustomNavItem.build(
        context: context,
        iconPath: AppImages.order,
        title: "My Order",
      ),
      CustomNavItem.build(
        context: context,
        iconPath: AppImages.favorite,
        title: "Favorite",
      ),
      CustomNavItem.build(
        context: context,
        iconPath: AppImages.profile,
        title: "My Profile",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,

      tabs: [
        PersistentTabConfig(
          screen: _screens(context)[0],
          item: _navBarsItems()[0],
        ),
        PersistentTabConfig(
          screen: _screens(context)[1],
          item: _navBarsItems()[1],
        ),
        PersistentTabConfig(
          screen: _screens(context)[2],
          item: _navBarsItems()[2],
        ),
        PersistentTabConfig(
          screen: _screens(context)[3],
          item: _navBarsItems()[3],
        ),
      ],
      navBarBuilder: ((navBarConfig) => Style6BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: Offset(0, -3),
            ),
          ],
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 0.8),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
      )),
      screenTransitionAnimation: ScreenTransitionAnimation(),
      // backgroundColor: Colors.white,
      // handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement:
          false, // to re-build widgets by using cubit , default is true
      // hideNavigationBar: true,
    );
  }
}
