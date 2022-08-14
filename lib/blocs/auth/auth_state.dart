part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait...',
  });
}

class AuthInitial extends AuthState {
  const AuthInitial({required bool isLoading}) : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final User user;
  const AuthStateLoggedIn({
    required this.user,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateRequestOTP extends AuthState {
  final Exception? exception;
  const AuthStateRequestOTP({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateVerifyOTP extends AuthState {
  final String verificationId;
  final Exception? exception;
  const AuthStateVerifyOTP({
    required this.verificationId,
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}
