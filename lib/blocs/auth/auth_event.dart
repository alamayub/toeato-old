part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogin(this.email, this.password);
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventRegister extends AuthEvent {
  final String name;
  final String mobile;
  final String email;
  final String password;
  const AuthEventRegister({
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
  });
}

class AuthEventShouldRequestOTP extends AuthEvent {
  const AuthEventShouldRequestOTP();
}

class AuthEventRequestOTP extends AuthEvent {
  final String mobile;
  const AuthEventRequestOTP({required this.mobile});
}

class AuthEventShouldVerifyOTP extends AuthEvent {
  const AuthEventShouldVerifyOTP();
}

class AuthEventVerifyOTP extends AuthEvent {
  final String otp;
  const AuthEventVerifyOTP({required this.otp});
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}
