import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/interfaces/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit({required this.userRepository}) : super(const ProfileState());

  void usernameChanged(String value) {
    emit(state.copyWith(username: value));
  }

  void bioChanged(String value) {
    emit(state.copyWith(bio: value));
  }

  void photoFileUploaded(Uint8List file) {
    emit(state.copyWith(photoFile: file));
  }

  userLoaded(String userId) async {
    final failureOrUser = await userRepository.getUser(userId);

    failureOrUser.fold(
      (failure) async => emit(
        state.copyWith(
            status: ProfileStatus.failure, errorMessage: failure.message),
      ),
      (user) async => emit(
        state.copyWith(
          username: user.username,
          bio: user.biography,
          photoUrl: user.photoUrl,
          following: user.following.length,
          followers: user.followers.length,
        ),
      ),
    );
  }

  userUpdated(User user) async {
    emit(
      state.copyWith(status: ProfileStatus.loading),
    );

    final newUser = user.copyWith(
      username: state.username,
      photoUrl: state.photoUrl,
      biography: state.bio,
    );

    final failureOrUpated =
        await userRepository.updateUser(newUser, state.photoFile);

    failureOrUpated.fold(
      (failure) => emit(
        state.copyWith(
            status: ProfileStatus.failure, errorMessage: failure.message),
      ),
      (success) async {
        await userLoaded(user.id);

        emit(
          state.copyWith(status: ProfileStatus.success),
        );
      },
    );
  }
}
