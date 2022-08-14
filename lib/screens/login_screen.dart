import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toeato/widgets/auth_text.dart';
import 'package:toeato/widgets/inputs/custom_text_form_field.dart';
import '../../widgets/message_dialog.dart';
import '../../helper/extension/validator.dart';
import '../blocs/auth/auth_bloc.dart';
import '../services/exceptions.dart';
import '../widgets/custom_material_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
          title: const Text('Login'),
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
                CustomTextFormField(
                  textInputType: TextInputType.emailAddress,
                  controller: _email,
                  hint: 'toeato@toeato.com',
                  iconData: Icons.email,
                  validator: (val) => val?.isValidEmail(val),
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  obscure: true,
                  controller: _password,
                  hint: '******',
                  iconData: Icons.lock,
                  validator: (val) => val?.isValidPassword(val),
                ),
                const SizedBox(height: 12),
                CustomMaterialButton(
                  title: 'Login',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = _email.text.trim();
                      final password = _password.text.trim();
                      context
                          .read<AuthBloc>()
                          .add(AuthEventLogin(email, password));
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
                  title: 'Continue with Mobile Number',
                  onPressed: () async {
                    FocusScope.of(context).nextFocus();
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventShouldRequestOTP());
                  },
                ),
                const SizedBox(height: 12),
                AuthText(
                  text1: 'Don\'t have account?',
                  function: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventShouldRegister());
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
