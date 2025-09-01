import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces/i_journal_repository.dart';
import '../models/journal_entry.dart';

class JournalRepository implements IJournalRepository {
  JournalRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _db.collection('users').doc(uid).collection('entries');

  @override
  Future<String> create(JournalEntry entry) async {
    final doc = _col(entry.uid).doc();
    final data = entry.toMap()..['id'] = doc.id;
    data['createdAt'] = FieldValue.serverTimestamp();
    data['updatedAt'] = FieldValue.serverTimestamp();
    await doc.set(data);
    return doc.id;
  }
}
