import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../../core/validator/form_validator.dart';
import '../../../data/models/form/email.dart';
import '../../../data/models/form/password.dart';
import '../../../data/repositories/interfaces/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({
    required this.authenticationRepository,
  }) : super(const LoginState());

  void emailChanged(String value) {
    final email = Email(value);

    emit(
      state.copyWith(
        email: email,
        status: FormValidator.validate(
          [
            email,
            state.password,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password(value);

    emit(
      state.copyWith(
          password: password,
          status: FormValidator.validate(
            [
              state.email,
              password,
            ],
          )),
    );
  }

  void obscureText() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    final failureOrLogin =
        await authenticationRepository.logInWithEmailAndPassword(
      email: state.email.value,
      password: state.password.value,
    );

    _eitherLoggedOrErrorState(failureOrLogin);
  }

  Future<void> logInWithGoogle() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    final failureOrLogin = await authenticationRepository.logInWithGoogle();

    _eitherLoggedOrErrorState(failureOrLogin);
  }

  _eitherLoggedOrErrorState(Either<Failure, Unit> either) {
    either.fold(
      (failure) => state.copyWith(
        errorMessage: failure.message,
        status: FormStatus.failure,
      ),
      (success) => emit(
        state.copyWith(
          status: FormStatus.success,
        ),
      ),
    );
  }
}
