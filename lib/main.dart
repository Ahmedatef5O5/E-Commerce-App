import 'package:ecommerce_app/Authentication/login_view.dart';
import 'package:ecommerce_app/Router/app_router.dart';
import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/views/custom_buttom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CartCubit()..getCartItem(),
      child: const EcommerceApp(),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff514eb7),
        // primaryColor: const Color(0xFFFE724C),
        // secondaryHeaderColor: const Color(0xFFFE724C).withOpacity(0.5),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      initialRoute: AppRoutes.loginViewRoute,
      // initialRoute: AppRoutes.homeRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
