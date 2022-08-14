abstract class UserProvider {
  Future<void> createUser({
    required String name,
    required String mobile,
    required String email,
  });

  Future<void> updateUser({
    required String name,
    required String mobile,
    required String email,
    required String password,
  });
}
