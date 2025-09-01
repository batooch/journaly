import 'package:get/get.dart';
import '../interfaces/i_auth_service.dart';
import '../navigation/app_routes.dart';

class AuthController extends GetxController {
  AuthController(this._authService);

  final IAuthService _authService;

  final isLoading = false.obs;
  final error = RxnString();
  final uid = RxnString();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    error.value = null;
    try {
      final userId = await _authService.loginUser(
        email: email,
        password: password,
      );
      uid.value = userId; // optional verfügbar
      Get.offAllNamed(AppRoutes.home); // direkt nach Home
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    isLoading.value = true;
    error.value = null;
    try {
      final userId = await _authService.registerUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      uid.value = userId;
      Get.offAllNamed(AppRoutes.home); // nach Registrierung direkt in die App
      // Wenn du stattdessen erst zum Login willst:
      // Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    uid.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}
