import '../../../core/validator/validator_mixin.dart';
import '../../../core/validator/form_input.dart';

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
