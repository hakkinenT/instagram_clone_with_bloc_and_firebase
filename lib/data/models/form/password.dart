import 'package:school_management/core/validator/form_input.dart';
import 'package:school_management/core/validator/validator_mixin.dart';

class Password extends FormInput<String> with ValidatorMixin {
  const Password(super.value);

  const Password.initial() : super('');

  @override
  String? validator() {
    return combine(
      [
        () => isNotEmpty(value),
        () => isPasswordValid(value),
      ],
    );
  }
}
