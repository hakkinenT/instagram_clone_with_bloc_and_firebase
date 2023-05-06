part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final Username username;
  final Email email;
  final Password password;
  final FormStatus status;
  final String? errorMessage;
  final bool obscurePassword;

  const SignUpState({
    this.username = const Username(''),
    this.email = const Email(''),
    this.password = const Password(''),
    this.status = FormStatus.initial,
    this.obscurePassword = true,
    this.errorMessage,
  });

  SignUpState copyWith({
    Username? username,
    Email? email,
    Password? password,
    FormStatus? status,
    String? errorMessage,
    bool? obscurePassword,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        status,
        errorMessage,
        obscurePassword,
      ];
}
