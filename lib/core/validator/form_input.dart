abstract class FormInput<T> {
  final T value;

  const FormInput(this.value);

  bool get valid => validator() == null;

  bool get invalid => validator() != null;

  String? get errorMessage => validator();

  String? validator();
}
