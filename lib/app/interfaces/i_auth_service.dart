import 'package:firebase_auth/firebase_auth.dart';

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

  User? get currentUser;

  /// praktische Kurzform für die UID des aktuellen Users
  String? get currentUid;
}
