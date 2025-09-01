import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/free_journaling_controller.dart';
import '../interfaces/i_auth_service.dart';
import '../interfaces/i_journal_repository.dart';
import '../repositories/journal_repository.dart';

class FreeJournalingBinding extends Bindings {
  @override
  void dependencies() {
    // JournalRepository registrieren und an das Interface binden
    Get.lazyPut<IJournalRepository>(
      () => JournalRepository(FirebaseFirestore.instance),
      fenix: true,
    );

    // Controller bekommt Repo + AuthService
    Get.lazyPut<FreeJournalingController>(
      () => FreeJournalingController(
        repo: Get.find<IJournalRepository>(),
        auth: Get.find<IAuthService>(),
      ),
    );
  }
}
