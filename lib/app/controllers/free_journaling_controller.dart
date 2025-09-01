// lib/app/controllers/free_journaling_controller.dart
import 'package:get/get.dart';

import '../interfaces/i_auth_service.dart';
import '../interfaces/i_journal_repository.dart';
import '../models/journal_entry.dart';
import '../repositories/journal_repository.dart';

class FreeJournalingController extends GetxController {
  FreeJournalingController({
    required this.repo,
    required this.auth,
  });

  final IJournalRepository repo;
  final IAuthService auth;

  final isSaving = false.obs;
  final lastError = RxnString();

  /// Speichert einen Eintrag (Titel + Delta JSON)
  /// [deltaJson] erwartet z. B. { "ops": [...] }
  Future<String?> save({
    required String title,
    required Map<String, dynamic> deltaJson,
  }) async {
    final uid = auth.currentUid; // <- kommt aus deinem IAuthService
    if (uid == null) {
      lastError.value = 'Nicht eingeloggt';
      return null;
    }

    isSaving.value = true;
    lastError.value = null;

    try {
      final now = DateTime.now();
      final entry = JournalEntry(
        id: '',
        uid: uid,
        title: title.isEmpty ? 'Untitled' : title,
        contentDelta: deltaJson,
        createdAt: now,
        updatedAt: now,
      );

      final id = await repo.create(entry);
      return id;
    } catch (e) {
      lastError.value = e.toString();
      return null;
    } finally {
      isSaving.value = false;
    }
  }
}
