import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/header_home_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.currentTabIndex,
    this.bgAppBarColor,
    this.centerTitle,
  });

  final int currentTabIndex;
  final Color? bgAppBarColor;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: centerTitle ?? false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: bgAppBarColor ?? AppColors.whiteColor,
      shadowColor: Colors.transparent,
      leading: _leadingWidget(context),
      title: _titleWidget(),
      titleSpacing: 14,
      actions: _actionsWidget(),
      actionsPadding: EdgeInsets.only(right: 14),
    );
  }

  Widget _titleWidget() {
    switch (currentTabIndex) {
      case 0:
        return HeaderHomeSection();
      case 1:
        return Text('My Cart', style: TextStyle(fontSize: 18));
      case 2:
        return Text('Favorites', style: TextStyle(fontSize: 18));
      case 3:
        return Text('Profile', style: TextStyle(fontSize: 18));
      default:
        return SizedBox.shrink();
    }
  }

  List<Widget>? _actionsWidget() {
    switch (currentTabIndex) {
      case 0:
        return null;
      case 1:
        return [Icon(Icons.shopping_bag_outlined, size: 26)];

      case 2:
        return [Icon(CupertinoIcons.heart, size: 26)];
      case 3:
        return [Icon(CupertinoIcons.person, size: 26)];
      default:
        return null;
    }
  }

  Widget? _leadingWidget(BuildContext context) {
    // if (currentTabIndex != 0) {
    //   return IconButton(
    //     icon: Icon(Icons.arrow_back_ios_new, size: 22),
    //     onPressed: () {
    //       // Navigator.of(context).maybePop();
    //     },
    //   );
    // }
    return null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
