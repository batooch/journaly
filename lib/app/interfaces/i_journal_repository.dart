import '../models/journal_entry.dart';

abstract class IJournalRepository {
  Future<String> create(JournalEntry entry);
}
