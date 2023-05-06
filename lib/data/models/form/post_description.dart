import '../../../core/validator/validator_mixin.dart';
import '../../../core/validator/form_input.dart';

class PostDescription extends FormInput<String> with ValidatorMixin {
  const PostDescription(super.value);

  const PostDescription.initial() : super('');

  @override
  String? validator() {
    return combine(
      [
        () => isNotEmpty(value),
      ],
    );
  }
}
