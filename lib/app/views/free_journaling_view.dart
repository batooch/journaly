import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';

import '../constants/app_texts.dart';
import '../widgets/journal_editor.dart';
import '../widgets/journal_toolbar.dart';

class FreeJournalingView extends StatefulWidget {
  const FreeJournalingView({super.key});

  @override
  State<FreeJournalingView> createState() => _FreeJournalingState();
}

class _FreeJournalingState extends State<FreeJournalingView> {
  late final FleatherController _controller; // verwaltet den Text
  final FocusNode _focusNode = FocusNode(); // steuert Cursor-Fokus

  @override
  void initState() {
    super.initState();
    _controller = FleatherController(); // startet mit leerem Dokument
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.journalTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toolbar zum Formatieren
            JournalToolbar(controller: _controller),
            const SizedBox(height: 12),
            // Editor füllt restlichen Platz
            Expanded(
              child: JournalEditor(
                controller: _controller,
                focusNode: _focusNode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
