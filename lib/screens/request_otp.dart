import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/message_dialog.dart';
import '../blocs/auth/auth_bloc.dart';
import '../services/exceptions.dart';
import '../widgets/auth_text.dart';
import '../widgets/custom_material_button.dart';
import '../widgets/inputs/custom_number_form_field.dart';

class RequestOTPScreen extends StatefulWidget {
  const RequestOTPScreen({Key? key}) : super(key: key);

  @override
  State<RequestOTPScreen> createState() => _RequestOTPScreenState();
}

class _RequestOTPScreenState extends State<RequestOTPScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _mobile;

  @override
  void initState() {
    _mobile = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _mobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await messageDialog(context, 'User not found!');
          } else if (state.exception is WrongPasswordAuthException) {
            await messageDialog(context, 'Wrong Password!');
          } else if (state.exception is GenericAuthException) {
            await messageDialog(context, 'Authentication Error!');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login With Mobile Number'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNumberFormField(
                  controller: _mobile,
                ),
                const SizedBox(height: 12),
                CustomMaterialButton(
                  title: 'Login',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final mobile = _mobile.text.trim();
                      context
                          .read<AuthBloc>()
                          .add(AuthEventRequestOTP(mobile: mobile));
                    }
                  },
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'OR',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 12),
                CustomMaterialButton(
                  title: 'Continue with Email & Password',
                  onPressed: () async {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                  },
                ),
                const SizedBox(height: 12),
                AuthText(
                  text1: 'Don\'t have account?',
                  function: () {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                  },
                  text2: 'Create One',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
