import 'package:ecommerce_app/Authentication/register_view.dart';
import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/cubit/Choose_Location_cubit/choose_location_cubit.dart';
import 'package:ecommerce_app/cubit/Payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/cubit/Product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/models/product_details_args_model.dart';
import 'package:ecommerce_app/views/add_new_card_view.dart';
import 'package:ecommerce_app/views/checkout_view.dart';
import 'package:ecommerce_app/views/custom_buttom_nav_bar.dart';
import 'package:ecommerce_app/views/location_view.dart';
import 'package:ecommerce_app/views/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Authentication/login_view.dart';
import '../views/splash_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => SplashView(),
          settings: settings,
        );

      case AppRoutes.loginViewRoute:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
          settings: settings,
        );

      case AppRoutes.registerViewRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterView(),
          settings: settings,
        );

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
      case AppRoutes.locationViewRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChooseLocationCubit();
              cubit.fetchLocations();
              return cubit;
            },
            child: const LocationView(),
          ),
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
