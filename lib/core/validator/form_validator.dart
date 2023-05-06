import 'form_input.dart';

enum FormStatus {
  initial,
  success,
  failure,
  invalid,
  loading,
  validated;

  bool get isInitial => this == FormStatus.initial;

  bool get isSuccess => this == FormStatus.success;

  bool get isFailure => this == FormStatus.failure;

  bool get isValidated => this == FormStatus.validated;

  bool get isLoading => this == FormStatus.loading;

  bool get isInvalid => this == FormStatus.invalid;
}

class FormValidator {
  static FormStatus validate(List<FormInput<dynamic>> inputs) {
    final bool isValidated = inputs.every((input) => input.valid);

    if (isValidated) {
      return FormStatus.validated;
    } else {
      return FormStatus.invalid;
    }
  }
}
