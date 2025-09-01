import 'package:get/get.dart';
import '../interfaces/i_auth_service.dart';
import '../services/auth_service.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Interface auf Implementierung mappen
    Get.lazyPut<IAuthService>(() => AuthService(), fenix: true);
    Get.put<AuthController>(
      AuthController(Get.find<IAuthService>()),
      permanent: true,
    );
  }
}
