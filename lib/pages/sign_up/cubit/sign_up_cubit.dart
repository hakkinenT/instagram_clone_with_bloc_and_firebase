import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:school_management/data/repositories/interfaces/authentication_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/validator/form_validator.dart';
import '../../../data/models/form/email.dart';
import '../../../data/models/form/password.dart';
import '../../../data/models/form/username.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository authenticationRepository;

  SignUpCubit({required this.authenticationRepository})
      : super(const SignUpState());

  void usernameChanged(String value) {
    final username = Username(value);

    emit(
      state.copyWith(
        username: username,
        status: FormValidator.validate(
          [
            username,
            state.email,
            state.password,
          ],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email(value);

    emit(
      state.copyWith(
        email: email,
        status: FormValidator.validate(
          [
            state.username,
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
              state.username,
              state.email,
              password,
            ],
          )),
    );
  }

  void obscureText() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    final failureOrSignUp = await authenticationRepository.signUp(
      username: state.username.value,
      email: state.email.value,
      password: state.password.value,
    );

    _eitherLoggedOrErrorState(failureOrSignUp);
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
