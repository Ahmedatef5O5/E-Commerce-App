import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/models/product_details_args_model.dart';
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
        // final args = settings.arguments as Map;

        final args = settings.arguments as ProductDetailsArgsModel;
        // final ProductItemModel product = args['product'];
        // final id = ProductDetailsArgsModel(id: args.id);
        return MaterialPageRoute(
          settings: settings, // helping for any passed parameters
          builder: (_) => ProductDetailsView(productId: args.id),
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
