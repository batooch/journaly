import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';

class JournalToolbar extends StatelessWidget {
  const JournalToolbar({super.key, required this.controller});

  final FleatherController controller; // wird mit demselben Controller wie der Editor verbunden

  @override
  Widget build(BuildContext context) {
    return FleatherToolbar.basic(
      controller: controller, // sorgt dafür, dass Toolbar-Aktionen den Editor-Inhalt beeinflussen
    );
  }
}
