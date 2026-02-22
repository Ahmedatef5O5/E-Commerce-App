import 'package:ecommerce_app/Router/app_router.dart';
import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/cubit/Cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/cubit/Favorite_cubit/favorite_cubit.dart';
import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission ✅');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted provisional permission 🟡');
  } else {
    debugPrint('User declined or has not accepted permission ❌');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await requestNotificationPermission();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..checkAuthStatus()),
        BlocProvider(create: (context) => HomeCubit()..getHomeData()),
        BlocProvider(
          create: (context) => FavoriteCubit()..getFavoriteProducts(),
        ),
        BlocProvider(create: (context) => CartCubit()..listenToCartItems()),
      ],
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
      initialRoute: AppRoutes.splashRoute,
      // initialRoute: AppRoutes.loginViewRoute,
      // initialRoute: AppRoutes.homeRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
