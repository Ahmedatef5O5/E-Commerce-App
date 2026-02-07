import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/views/custom_buttom_nav_bar.dart';
import 'package:ecommerce_app/views/product_details_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          settings: settings, // helping for any passed parameters
          builder: (_) => const CustomButtomNavbar(),
        );

      case AppRoutes.productDetailsRoute:
        return MaterialPageRoute(
          settings: settings, // helping for any passed parameters
          builder: (_) => ProductDetailsView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
