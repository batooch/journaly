import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/app_texts.dart';
import '../widgets/journal_editor.dart';
import '../widgets/journal_toolbar.dart';
import '../controllers/free_journaling_controller.dart';

class FreeJournalingView extends StatefulWidget {
  const FreeJournalingView({super.key});

  @override
  State<FreeJournalingView> createState() => _FreeJournalingViewState();
}

class _FreeJournalingViewState extends State<FreeJournalingView> {
  late final FleatherController _controller;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _titleCtrl = TextEditingController();
  late final String _today;

  @override
  void initState() {
    super.initState();
    _controller = FleatherController();
    _today = DateFormat('EEEE, d. MMMM yyyy – HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    final c = Get.find<FreeJournalingController>();

    // Delta sauber serialisieren
    final ops =
        _controller.document
            .toDelta()
            .toList()
            .map((op) => op.toJson())
            .toList();

    final deltaJson = <String, dynamic>{'ops': ops};

    final id = await c.save(
      title: _titleCtrl.text.trim(),
      deltaJson: deltaJson,
    );

    if (id != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gespeichert ✓ (ID: $id)')));
      Navigator.of(context).pop(); // zurück zur Home-Seite
    } else if (c.lastError.value != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Fehler: ${c.lastError.value}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.journalTitle),
        actions: [
          Obx(() {
            final c = Get.find<FreeJournalingController>();
            return c.isSaving.value
                ? const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : IconButton(
                  icon: const Icon(Icons.check),
                  tooltip: 'Speichern',
                  onPressed: _onSave,
                );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Datum
            Text(_today, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            // Titel
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                hintText: 'Titel',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            // Toolbar
            JournalToolbar(controller: _controller),
            const SizedBox(height: 12),
            // Editor
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
