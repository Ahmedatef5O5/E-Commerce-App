import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/cubit/Product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/models/product_details_args_model.dart';
import 'package:ecommerce_app/views/add_new_card_view.dart';
import 'package:ecommerce_app/views/checkout_view.dart';
import 'package:ecommerce_app/views/custom_buttom_nav_bar.dart';
import 'package:ecommerce_app/views/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const CustomButtomNavbar(),
          settings: settings, // helping for any passed parameters
        );

      case AppRoutes.productDetailsRoute:
        // final args = settings.arguments as Map;

        final args = settings.arguments as ProductDetailsArgsModel;
        // final ProductItemModel product = args['product'];
        // final id = ProductDetailsArgsModel(id: args.id);
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(args.id);
              return cubit;
            },
            child: ProductDetailsView(productId: args.id),
          ),
          settings: settings, // helping for any passed parameters
        );

      case AppRoutes.checkoutViewRoute:
        // final args = settings.arguments as Map;
        // final args = settings.arguments as ProductDetailsArgsModel;
        // final ProductItemModel product = args['product'];
        // final id = ProductDetailsArgsModel(id: args.id);

        return MaterialPageRoute(
          builder: (_) => CheckoutView(),
          settings: settings, // helping for any passed parameters
        );

      case AppRoutes.addNewCardViewRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = PaymentMethodsCubit();
              return cubit;
            },
            child: AddNewCardView(),
          ),
          settings: settings,
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
