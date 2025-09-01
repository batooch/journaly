import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';
import 'package:intl/intl.dart';

import '../widgets/journal_editor.dart';
import '../widgets/journal_toolbar.dart';

class FreeJournalingView extends StatefulWidget {
  const FreeJournalingView({super.key});

  @override
  State<FreeJournalingView> createState() => _FreeJournalingViewState();
}

class _FreeJournalingViewState extends State<FreeJournalingView> {
  late final FleatherController _controller;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _titleCtrl = TextEditingController();

  late final String _today; // z. B. "Sunday, Sep 1"

  @override
  void initState() {
    super.initState();
    _controller = FleatherController();
    _today = DateFormat('EEEE, d. MMM').format(DateTime.now());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }

  void _onSave() {
    final title = _titleCtrl.text.trim();
    final delta = _controller.document.toDelta();
    // TODO: hier ins Repository speichern (title, delta, createdAt)
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Entry saved (stub)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Fertig',
            onPressed: _onSave,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Datum
            Text(_today, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            // Titel
            TextField(
              controller: _titleCtrl,
              textInputAction: TextInputAction.next,
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
