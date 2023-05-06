import '../../../core/validator/validator_mixin.dart';
import '../../../core/validator/form_input.dart';

class CommentText extends FormInput<String> with ValidatorMixin {
  const CommentText(super.value);

  const CommentText.initial() : super('');

  @override
  String? validator() {
    return combine(
      [
        () => isNotEmpty(value),
      ],
    );
  }
}
