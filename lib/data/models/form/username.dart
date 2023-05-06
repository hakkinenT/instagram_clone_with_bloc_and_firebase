import 'package:school_management/core/validator/form_input.dart';
import 'package:school_management/core/validator/validator_mixin.dart';

class Username extends FormInput<String> with ValidatorMixin {
  const Username(super.value);

  const Username.initial() : super('');

  @override
  String? validator() {
    return combine(
      [
        () => isNotEmpty(value),
      ],
    );
  }
}
