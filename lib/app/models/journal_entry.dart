import 'package:cloud_firestore/cloud_firestore.dart';

class JournalEntry {
  final String id;
  final String uid;
  final String title;
  final Map<String, dynamic> contentDelta;
  final DateTime createdAt;
  final DateTime updatedAt;

  JournalEntry({
    required this.id,
    required this.uid,
    required this.title,
    required this.contentDelta,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'uid': uid,
    'title': title,
    'contentDelta': contentDelta,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  factory JournalEntry.fromMap(Map<String, dynamic> m) => JournalEntry(
    id: m['id'] as String,
    uid: m['uid'] as String,
    title: m['title'] as String? ?? '',
    contentDelta: Map<String, dynamic>.from(m['contentDelta']),
    createdAt: (m['createdAt'] as Timestamp).toDate(),
    updatedAt: (m['updatedAt'] as Timestamp).toDate(),
  );
}
