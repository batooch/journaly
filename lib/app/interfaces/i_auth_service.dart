abstract class IAuthService {
  Future<String> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<String> loginUser({required String email, required String password});

  Future<void> logout();

  Future<Map<String, dynamic>> getUserData(String uid);
}
