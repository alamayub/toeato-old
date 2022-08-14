import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/message_dialog.dart';
import '../../helper/extension/validator.dart';
import '../blocs/auth/auth_bloc.dart';
import '../services/exceptions.dart';
import '../widgets/auth_text.dart';
import '../widgets/custom_material_button.dart';
import '../widgets/inputs/custom_number_form_field.dart';
import '../widgets/inputs/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _mobile;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _mobile = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await messageDialog(context, 'Please use a strong password!');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await messageDialog(
              context,
              'This email is already used by another account!',
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await messageDialog(context, 'Invalid email!');
          } else if (state.exception is ProviderAlreadyLinkedAuthException) {
            await messageDialog(context,
                'Looks like this email is already used by another account!');
          } else if (state.exception
              is AccountExistWithDifferentCredentialAuthException) {
            await messageDialog(
                context, 'The account is already used by another user!');
          } else if (state.exception is InvalidCredentialAuthException) {
            await messageDialog(context, 'Invalid auth credential!');
          } else if (state.exception is OperationNotAllowedAuthException) {
            await messageDialog(context, 'Operation not allowed!');
          } else if (state.exception is GenericAuthException) {
            await messageDialog(context, 'Authentication Error!');
          }
          /*else if (e.code == 'user-disabled') {
            throw UserDisabledAuthException();
          } else if (e.code == 'user-not-found') {
            throw UserNotFoundAuthException();
          } else if (e.code == 'wrong-password') {
            throw WrongPasswordAuthException();
          } else if (e.code == 'invalid-verification-code') {
            throw InvalidVerificationCodeAuthException();
          } else if (e.code == 'invalid-verification-id') {
            throw InvalidVerificationIdAuthException();
          }*/
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
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
                  textInputType: TextInputType.name,
                  iconData: Icons.person,
                  textCapitalize: true,
                  controller: _name,
                  hint: 'Toeato Toeato',
                  validator: (val) => val?.isValidName(val),
                ),
                const SizedBox(height: 12),
                CustomNumberFormField(
                  controller: _mobile,
                ),
                const SizedBox(height: 12),
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
                  controller: _password,
                  hint: '******',
                  iconData: Icons.lock,
                  validator: (val) => val?.isValidPassword(val),
                ),
                const SizedBox(height: 12),
                CustomMaterialButton(
                  title: 'Register',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).nextFocus();
                      final name = _name.text.trim();
                      final mobile = _mobile.text.trim();
                      final email = _email.text.trim();
                      final password = _password.text.trim();
                      context.read<AuthBloc>().add(AuthEventRegister(
                            name: name,
                            mobile: mobile,
                            email: email,
                            password: password,
                          ));
                    }
                  },
                ),
                const SizedBox(height: 12),
                AuthText(
                  text1: 'Already have account?',
                  function: () {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                  },
                  text2: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
