import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../exceptions.dart';
import 'auth_provider.dart';

class FirebaseAuthProvider implements AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // register user
  @override
  Future<User> createUser({
    required String name,
    required String mobile,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        return user;
      } else {
        log('31');
        throw UserNotFoundAuthException();
      }
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  // get current user
  @override
  User? get currentUser {
    final user = _auth.currentUser;
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  // login user
  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotFoundAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  // logout
  @override
  Future<void> logout() async {
    final user = _auth.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  // initialize firebase app
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // request OTP for user creation
  @override
  Future<String?> requestOTP({
    required String mobile,
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(PhoneAuthCredential phoneAuthCredential)
        verificationCompleted,
    required Function(String verificationId) codeAutoRetrievalTimeout,
  }) async {
    try {
      String? id;
      await _auth.verifyPhoneNumber(
        phoneNumber: '+977$mobile',
        codeSent: codeSent,
        verificationCompleted: verificationCompleted,
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            throw InvalidPhoneNumberAuthException();
          } else {
            throw GenericAuthException();
          }
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
      return id;
    } on FirebaseAuthException catch (_) {
      log('134');
      throw GenericAuthException();
    } catch (_) {
      log('137');
      throw GenericAuthException();
    }
  }

  // verify phone OTP sent to mobile number
  @override
  Future<PhoneAuthCredential> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    try {
      return PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
    } on FirebaseAuthException catch (e) {
      log('154, ${e.code}');
      if (e.code == 'provider-already-linked') {
        throw ProviderAlreadyLinkedAuthException();
      } else if (e.code == 'invalid-credential') {
        throw InvalidCredentialAuthException();
      } else if (e.code == 'credential-already-in-use') {
        throw CredentialAlreadyUsedByOtherAccountAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseByOtherAccountAuthException();
      } else if (e.code == 'operation-not-allowed') {
        throw OperationNotAllowedAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'invalid-verification-code') {
        throw InvalidVerificationCodeAuthException();
      } else if (e.code == 'invalid-verification-id') {
        throw InvalidVerificationIdAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  // login with mobile number credential
  @override
  Future<User> loginWithMobileCred({
    required PhoneAuthCredential phoneAuthCredential,
  }) async {
    try {
      var user = await _auth.signInWithCredential(phoneAuthCredential);
      if (user.user != null) {
        await user.user!.linkWithCredential(phoneAuthCredential);
        return user.user!;
      } else {
        log('191');
        throw UserNotFoundAuthException();
      }
    } on FirebaseAuthException catch (e) {
      log('195 ${e.code}');
      log('196 ${e.message}');
      if (e.code == 'provider-already-linked') {
        throw ProviderAlreadyLinkedAuthException();
      } else if (e.code == 'account-exists-with-different-credential') {
        throw AccountExistWithDifferentCredentialAuthException();
      } else if (e.code == 'invalid-credential') {
        throw InvalidCredentialAuthException();
      } else if (e.code == 'operation-not-allowed') {
        throw OperationNotAllowedAuthException();
      } else if (e.code == 'user-disabled') {
        throw UserDisabledAuthException();
      } else if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (e.code == 'invalid-verification-code') {
        throw InvalidVerificationCodeAuthException();
      } else if (e.code == 'invalid-verification-id') {
        throw InvalidVerificationIdAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
