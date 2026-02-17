import 'package:ecommerce_app/cubit/Auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();

    // Timer(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacementNamed(AppRoutes.loginViewRoute);
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
        } else if (state is AuthInitial || state is AuthError) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginViewRoute);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppImages.splash,
                    width: 300,
                    height: 320,
                  ),
                ),
                const Gap(45),

                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(15),
                CupertinoActivityIndicator(radius: 12, color: Colors.white10),
                const Gap(45),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
