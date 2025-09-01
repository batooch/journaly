import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../navigation/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              Get.offAllNamed(AppRoutes.login); // zurück zum Login
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Hier kommt später deine Journalliste rein'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.freeJournaling); // führt zur neuen Journal-Seite
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
