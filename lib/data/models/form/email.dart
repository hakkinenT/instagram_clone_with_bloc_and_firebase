import '../../../core/validator/validator_mixin.dart';
import '../../../core/validator/form_input.dart';

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
