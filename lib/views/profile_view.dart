import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../cubit/Auth_cubit/auth_cubit.dart';
import '../widgets/profile_info_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    // final authCubit = BlocProvider.of<AuthCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),
              Center(
                child: CircleAvatar(
                  radius: 56,
                  backgroundImage: AssetImage(AppImages.tempProfile),
                ),
              ),

              ProfileInfoTile(
                suffix: Image.asset(
                  AppImages.profile,
                  width: 30,
                  height: 30,
                  color: Theme.of(context).primaryColor,
                ),
                label: 'User Name',
                textInfo: 'Ahmed Atef',
              ),
              ProfileInfoTile(
                suffix: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                label: 'Email or Phone Number',
                textInfo: 'ahmedatef5668@test.com',
              ),
              ProfileInfoTile(
                suffix: Image.asset(AppImages.google, width: 28, height: 28),
                label: 'Account Linked With',
                textInfo: 'Google',
                prefix: Icon(
                  Icons.insert_link_outlined,
                  color: AppColors.blueGreyWithShade2,
                  size: 30,
                ),
              ),

              Gap(MediaQuery.of(context).size.height * 0.085),
              CustomElevatedButton(
                child: Text('Edit Profile'),
                onPressed: () {},
              ),
              Gap(25),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: authCubit,
                listenWhen: (previous, current) =>
                    current is AuthLoggedout || current is AuthLoggoutError,
                listener: (context, state) {
                  if (state is AuthLoggedout) {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamedAndRemoveUntil(
                      AppRoutes.loginViewRoute,
                      (roote) => false,
                    );
                  } else if (state is AuthLoggoutError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errMsg)));
                  }
                },
                buildWhen: (previous, current) =>
                    current is AuthLoggingout ||
                    current is AuthLoggedout ||
                    current is AuthLoggoutError ||
                    current is Authenticated,
                builder: (context, state) {
                  if (state is AuthLoggingout) {
                    return CustomElevatedButton(
                      onPressed: null,
                      child: CupertinoActivityIndicator(color: Colors.black12),
                    );
                  }
                  return CustomElevatedButton(
                    backgroundColor: Colors.red.shade700,
                    child: Text('Logout'),
                    onPressed: () async => await authCubit.logout(),
                  );
                },
              ),
              Gap(55),
            ],
          ),
        ),
      ),
    );
  }
}
