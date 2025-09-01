import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../interfaces/i_auth_service.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<String> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'registration-failed',
        message: 'User creation returned null.',
      );
    }

    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user.uid;
  }

  @override
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'login-failed',
          message: 'Login returned null.',
        );
      }
      return user.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('Diese E-Mail ist nicht registriert');
        case 'wrong-password':
          throw Exception('Falsches Passwort');
        case 'invalid-email':
          throw Exception('Ungültige E-Mail-Adresse');
        case 'invalid-credential':
          throw Exception('Falsche E-Mail/Passwort-Kombination');
        case 'too-many-requests':
          throw Exception(
              'Zu viele Versuche. Bitte warte kurz und versuche es erneut.');
        default:
          throw Exception(
              'Login fehlgeschlagen: Bitte überprüfe deine Eingaben.');
      }
    } catch (e) {
      throw Exception('Unbekannter Fehler beim Login: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<Map<String, dynamic>> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) throw Exception('Benutzer nicht gefunden');
    return doc.data()!;
  }

  /// Getter für aktuellen User
  @override
  User? get currentUser => _auth.currentUser;

  /// Getter für aktuelle UID
  @override
  String? get currentUid => _auth.currentUser?.uid;
}
