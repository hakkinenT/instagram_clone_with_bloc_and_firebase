mixin ValidatorMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? 'Este campo é obrigatório!';

    return null;
  }

  String? isEmailValid(String? value, [String? message]) {
    final bool emailValid = RegExp(
            r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
        .hasMatch(value!);

    if (!emailValid) {
      return message ?? 'Informe um email válido';
    }

    return null;
  }

  String? isPasswordValid(String? value, [String? message]) {
    final bool passwordValid =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value!);

    if (!passwordValid) {
      return message ?? 'Informe uma senha válida';
    }

    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();

      if (validation != null) return validation;
    }

    return null;
  }
}
