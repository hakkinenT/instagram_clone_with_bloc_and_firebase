part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormStatus status;
  final String? errorMessage;
  final bool obscurePassword;

  const LoginState({
    this.email = const Email(''),
    this.password = const Password(''),
    this.status = FormStatus.initial,
    this.obscurePassword = true,
    this.errorMessage,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    FormStatus? status,
    String? errorMessage,
    bool? obscurePassword,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
        obscurePassword,
      ];
}
