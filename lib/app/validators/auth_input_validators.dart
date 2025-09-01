class AuthInputValidators {
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Dieses Feld darf nicht leer sein';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'E-Mail darf nicht leer sein';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email.trim())) {
      return 'Ungültige E-Mail-Adresse';
    }

    return null;
  }

  static String? validatePasswordRegister(String? password) {
    if (password == null || password.isEmpty) {
      return 'Passwort darf nicht leer sein';
    }

    final regex = RegExp(r'^(?=.*[0-9]).{6,}$');
    if (!regex.hasMatch(password)) {
      return 'Mind. 6 Zeichen & mind. 1 Ziffer erforderlich';
    }

    return null;
  }

  static String? validatePasswordLogin(String? password) {
    if (password == null || password.isEmpty) {
      return 'Passwort darf nicht leer sein';
    }
    return null;
  }

  static String? validatePasswordRepeat(
      String? password,
      String? repeatPassword,
      ) {
    if (repeatPassword == null || repeatPassword.isEmpty) {
      return 'Bitte wiederhole dein Passwort';
    }

    if (password != repeatPassword) {
      return 'Passwörter stimmen nicht überein';
    }

    return null;
  }
}
