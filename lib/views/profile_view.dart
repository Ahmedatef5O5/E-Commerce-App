import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Auth_cubit/auth_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    // final authCubit = BlocProvider.of<AuthCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlocConsumer<AuthCubit, AuthState>(
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
                  child: Text('Logout'),
                  onPressed: () async => await authCubit.logout(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
