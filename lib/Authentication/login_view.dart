import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login Account',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontSize: 22),
              ),
              Gap(3),
              Text(
                'please login with registered account',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: 13,
                  color: AppColors.blueGreyWithShade4,
                ),
              ),
              Gap(32),
              Text(
                'Email or Phone Number',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontSize: 16),
              ),
              Gap(12),
              TextFormField(
                cursorColor: AppColors.blueGreyWithShade3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    // color: Colors.grey.shade300,
                    color: AppColors.blueGreyWithShade3,
                  ),
                  hintText: 'Enter your email or Phone Number',
                  hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueGreyWithShade3,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      width: 0.1,
                      color: Colors.grey.shade100,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                      width: 0.1,
                      // color: Colors.grey.shade300,
                      color: Colors.blueGrey.shade100,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.blueGrey.shade100,
                    ),
                  ),
                ),
              ),
              Gap(22),
              Text(
                'Password',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontSize: 16),
              ),
              Gap(12),
              TextFormField(
                cursorColor: AppColors.blueGreyWithShade3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  prefixIcon: Icon(
                    Icons.password,
                    // color: Colors.grey.shade300,
                    color: AppColors.blueGreyWithShade3,
                  ),
                  suffixIcon: Icon(
                    CupertinoIcons.eye,
                    // color: Colors.grey.shade300,
                    color: AppColors.blueGreyWithShade3,
                  ),
                  hintText: 'Create your password',
                  hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueGreyWithShade3,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      width: 0.1,
                      color: Colors.blueGrey.shade100,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                      width: 0.1,
                      color: Colors.blueGrey.shade100,
                      // color: AppColors.blueGreyWithShade3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.blueGrey.shade100,
                    ),
                  ),
                ),
              ),
              Gap(4),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      // color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Gap(25),
              CustomElevatedButton(
                // width: MediaQuery.of(context).size.width * 0.75,
                child: Text('Sign In'),
                onPressed: () {},
              ),
              Gap(20),
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  textAlign: TextAlign.center,
                  'Or using other method',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueGreyWithShade3,
                  ),
                ),
              ),

              Gap(20),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: BorderSide(width: .8, color: Colors.blueGrey.shade100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.google, height: 30, width: 30),
                      Gap(12),
                      Text(
                        'Sign In with Google',
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: BorderSide(width: .8, color: Colors.blueGrey.shade100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.facebook, height: 30, width: 30),
                      Gap(12),
                      Text(
                        'Sign In with Facebook',
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}
