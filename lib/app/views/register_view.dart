import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../validators/auth_input_validators.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final first = TextEditingController();
  final last = TextEditingController();
  final email = TextEditingController();
  final pw = TextEditingController();
  final pw2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Registrieren')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: first,
                decoration: const InputDecoration(labelText: 'Vorname'),
                validator: AuthInputValidators.validateName,
              ),
              TextFormField(
                controller: last,
                decoration: const InputDecoration(labelText: 'Nachname'),
                validator: AuthInputValidators.validateName,
              ),
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
                validator: AuthInputValidators.validatePasswordRegister,
              ),
              TextFormField(
                controller: pw2,
                decoration: const InputDecoration(
                  labelText: 'Passwort wiederholen',
                ),
                obscureText: true,
                validator:
                    (v) => AuthInputValidators.validatePasswordRepeat(
                      pw.text,
                      v ?? '',
                    ),
              ),
              const SizedBox(height: 16),
              Obx(
                () =>
                    c.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await c.register(
                                email: email.text.trim(),
                                password: pw.text.trim(),
                                firstName: first.text.trim(),
                                lastName: last.text.trim(),
                              );
                              final err = c.error.value;
                              if (err != null) Get.snackbar('Fehler', err);
                            }
                          },
                          child: const Text('Konto erstellen'),
                        ),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Schon ein Konto? Zum Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
