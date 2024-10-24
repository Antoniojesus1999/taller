class Helpers {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacío';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  static String? validateEmptyPass(String? password1) {
    if (password1 == null) {
      return 'La contraseña tiene el valor null';
    }
    if (password1.isEmpty) {
      return 'Este campo no puede estar vacío';
    }
    if (password1.length < 6) {
      return 'Debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? validateEmpty(String? password1) {
    if (  password1 == null || password1.isEmpty) {
      return 'Rellene este campo';
    }
    return null;
  }

  static String? validatePasword(String? password1, String? password2) {
    if (password2 == null) {
      return 'La segunda contraseña tiene el valor null';
    }
    if (password2.isEmpty) {
      return 'Debes que completar las dos contraseñas';
    }
    if (password2.length < 6) {
      return 'Debe tener al menos 6 caracteres';
    }
    if (password1 != password2) {
      return 'Las contraseñas no son iguales';
    }
    return null;
  }
}
