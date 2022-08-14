import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toeato/widgets/inputs/custom_otp_form_field.dart';
import '../../widgets/message_dialog.dart';
import '../blocs/auth/auth_bloc.dart';
import '../services/exceptions.dart';
import '../widgets/custom_material_button.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _one;
  late final TextEditingController _two;
  late final TextEditingController _three;
  late final TextEditingController _four;
  late final TextEditingController _five;
  late final TextEditingController _six;

  @override
  void initState() {
    _one = TextEditingController();
    _two = TextEditingController();
    _three = TextEditingController();
    _four = TextEditingController();
    _five = TextEditingController();
    _six = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _one.dispose();
    _two.dispose();
    _three.dispose();
    _four.dispose();
    _five.dispose();
    _six.dispose();
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
          title: const Text('Verify OTP'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomOTPFormField(
                      controller: _one,
                      autoFocus: true,
                    ),
                    CustomOTPFormField(controller: _two),
                    CustomOTPFormField(controller: _three),
                    CustomOTPFormField(controller: _four),
                    CustomOTPFormField(controller: _five),
                    CustomOTPFormField(controller: _six),
                  ],
                ),
                const SizedBox(height: 12),
                CustomMaterialButton(
                  title: 'Login',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final otp = _one.text.trim() +
                          _two.text.trim() +
                          _three.text.trim() +
                          _four.text.trim() +
                          _five.text.trim() +
                          _six.text.trim();
                      context
                          .read<AuthBloc>()
                          .add(AuthEventVerifyOTP(otp: otp));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
