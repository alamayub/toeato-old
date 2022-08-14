import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toeato/screens/home_screen.dart';
import 'package:toeato/screens/request_otp.dart';

import '../blocs/auth/auth_bloc.dart';
import '../helper/loading/loading_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../widgets/loader.dart';
import 'verify_otp.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomeScreen();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        } else if (state is AuthStateRegistering) {
          return const RegisterScreen();
        } else if (state is AuthStateRequestOTP) {
          return const RequestOTPScreen();
        } else if (state is AuthStateVerifyOTP) {
          return const VerifyOTPScreen();
        } else {
          return const Scaffold(body: Loader());
        }
      },
    );
  }
}
