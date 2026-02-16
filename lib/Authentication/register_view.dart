import 'package:ecommerce_app/cubit/Auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
import 'package:ecommerce_app/widgets/label_with_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../Router/app_routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontSize: 22),
                ),
                Gap(3),
                Text(
                  'Start shopping with create your account',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 13,
                    color: AppColors.blueGreyWithShade4,
                  ),
                ),
                Gap(30),
                LabelWithTextField(
                  controller: _userNameController,
                  labelTxt: 'Username',
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontSize: 16),
                  hintTxt: 'Create your username',
                  hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueGreyWithShade3,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outlined,
                    // color: Colors.grey.shade300,
                    color: AppColors.blueGreyWithShade3,
                  ),
                ),
                Gap(16),
                LabelWithTextField(
                  controller: _emailController,
                  labelTxt: 'Email or Phone Number',
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontSize: 16),
                  hintTxt: 'Enter your email or Phone Number',
                  hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueGreyWithShade3,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    // color: Colors.grey.shade300,
                    color: AppColors.blueGreyWithShade3,
                  ),
                ),
                Gap(16),
                LabelWithTextField(
                  controller: _passwordController,
                  isPassword: true,
                  labelTxt: 'Password',
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontSize: 16),
                  hintTxt: 'Create your password',
                  hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueGreyWithShade3,
                  ),
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.visibility_outlined),
                ),
                Gap(2),
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

                BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is AuthSuccess || current is AuthError,
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.successMsg)));

                      Navigator.of(context).pushNamed(AppRoutes.loginViewRoute);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.errMsg)));
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AuthLoading ||
                      current is AuthError ||
                      current is AuthSuccess,
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CustomElevatedButton(
                        // width: MediaQuery.of(context).size.width * 0.75,
                        onPressed: null,
                        // width: MediaQuery.of(context).size.width * 0.75,
                        child: Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.black12,
                          ),
                        ),
                      );
                    }
                    return CustomElevatedButton(
                      // width: MediaQuery.of(context).size.width * 0.75,
                      child: Text('Create Account'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await cubit.registerWithEmailAndPassword(
                            _userNameController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                Gap(4),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.loginViewRoute);
                        },
                        child: Text(
                          'Already have an account? Login',
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                      Gap(8),
                      Text(
                        textAlign: TextAlign.center,
                        'Or using other method',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blueGreyWithShade3,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(14),
                Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                    side: BorderSide(
                      width: .8,
                      color: Colors.blueGrey.shade100,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.google, height: 30, width: 30),
                        Gap(12),
                        Text(
                          'Register with Google',
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
                Gap(10),
                Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                    side: BorderSide(
                      width: .8,
                      color: Colors.blueGrey.shade100,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.facebook, height: 30, width: 30),
                        Gap(12),
                        Text(
                          'Register with Facebook',
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
      ),
    );
  }
}
