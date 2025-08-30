import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';

class JournalEditor extends StatelessWidget {
  const JournalEditor({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final FleatherController controller; // hält den Text & die Formatierungen
  final FocusNode focusNode; // bestimmt, ob das Textfeld gerade fokussiert ist

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ), // Rahmenfarbe abhängig vom Theme
        borderRadius: BorderRadius.circular(12), // abgerundete Ecken
      ),
      child: Padding(
        padding: const EdgeInsets.all(12), // Innenabstand
        child: FleatherEditor(
          controller: controller,
          // verbindet den Editor mit dem Controller (Text + Formatierungen)
          focusNode: focusNode,
          // sorgt dafür, dass der Editor weiß, wann er Eingaben annehmen soll
          // zeigt den Hinweistext, wenn noch nichts geschrieben wurde
          scrollable: true,
          // macht das Feld scrollbar, falls Text zu lang
          expands:
              true, // füllt den ganzen Platz aus (wichtig in Kombination mit Expanded)
        ),
      ),
    );
  }
}
