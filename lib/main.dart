import 'package:ecommerce_app/Router/app_router.dart';
import 'package:ecommerce_app/views/custom_buttom_nav_bar.dart';
import 'package:ecommerce_app/views/product_details_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
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
      // home: ProductDetailsView(productId: '3'),
      home: CustomButtomNavbar(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
