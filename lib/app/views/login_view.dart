import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../validators/auth_input_validators.dart'; // dein Code
import '../navigation/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: AuthInputValidators.validateEmail,
              ),
              TextFormField(
                controller: pw,
                decoration: const InputDecoration(labelText: 'Passwort'),
                obscureText: true,
                validator: AuthInputValidators.validatePasswordLogin,
              ),
              const SizedBox(height: 16),
              Obx(
                () =>
                    c.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await c.login(email.text.trim(), pw.text.trim());
                              final err = c.error.value;
                              if (err != null) Get.snackbar('Fehler', err);
                            }
                          },
                          child: const Text('Anmelden'),
                        ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.register),
                child: const Text('Konto erstellen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
