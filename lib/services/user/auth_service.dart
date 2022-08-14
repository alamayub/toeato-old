import 'firestore_auth_provider.dart';
import 'user_provider.dart';

class UserService implements UserProvider {
  final UserProvider provider;
  const UserService(this.provider);

  factory UserService.firebase() => UserService(FirestoreAuthProvider());

  @override
  Future<void> createUser({
    required String name,
    required String mobile,
    required String email,
  }) =>
      provider.createUser(
        name: name,
        mobile: mobile,
        email: email,
      );

  @override
  Future<void> updateUser({
    required String name,
    required String mobile,
    required String email,
    required String password,
  }) =>
      provider.updateUser(
        name: name,
        mobile: mobile,
        email: email,
        password: password,
      );
}
