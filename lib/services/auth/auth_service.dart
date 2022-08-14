import 'package:firebase_auth/firebase_auth.dart';
import 'auth_provider.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<User> createUser({
    required String name,
    required String mobile,
    required String email,
    required String password,
  }) =>
      provider.createUser(
        name: name,
        mobile: mobile,
        email: email,
        password: password,
      );

  @override
  User? get currentUser => provider.currentUser;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<String?> requestOTP({
    required String mobile,
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(String verificationId) codeAutoRetrievalTimeout,
  }) =>
      provider.requestOTP(
        mobile: mobile,
        codeSent: codeSent,
        verificationCompleted: verificationCompleted,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );

  @override
  Future<PhoneAuthCredential> verifyOTP({
    required String verificationId,
    required String otp,
  }) =>
      provider.verifyOTP(
        verificationId: verificationId,
        otp: otp,
      );

  @override
  Future<User> loginWithMobileCred({
    required PhoneAuthCredential phoneAuthCredential,
  }) =>
      provider.loginWithMobileCred(
        phoneAuthCredential: phoneAuthCredential,
      );
}
