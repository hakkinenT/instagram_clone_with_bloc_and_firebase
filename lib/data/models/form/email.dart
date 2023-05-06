import 'package:school_management/core/validator/form_input.dart';
import 'package:school_management/core/validator/validator_mixin.dart';

class Email extends FormInput<String> with ValidatorMixin {
  const Email(super.value);

  const Email.initial() : super('');

  @override
  String? validator() {
    return combine(
      [
        () => isNotEmpty(value),
        () => isEmailValid(value),
      ],
    );
  }
}
