part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == ProfileStatus.loading;
  bool get isSuccess => this == ProfileStatus.success;
  bool get isFailure => this == ProfileStatus.failure;
}

class ProfileState extends Equatable {
  final String? username;
  final String? bio;
  final Uint8List? photoFile;
  final String? photoUrl;
  final int following;
  final int followers;
  final ProfileStatus status;
  final String? errorMessage;

  const ProfileState({
    this.username,
    this.bio,
    this.photoFile,
    this.photoUrl,
    this.following = 0,
    this.followers = 0,
    this.status = ProfileStatus.initial,
    this.errorMessage,
  });

  ProfileState copyWith({
    String? username,
    String? bio,
    Uint8List? photoFile,
    String? photoUrl,
    int? following,
    int? followers,
    ProfileStatus? status,
    String? errorMessage,
  }) {
    return ProfileState(
      username: username ?? this.username,
      bio: bio ?? this.bio,
      photoFile: photoFile ?? this.photoFile,
      photoUrl: photoUrl ?? this.photoUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        username,
        bio,
        photoFile,
        photoUrl,
        followers,
        following,
        status,
        errorMessage,
      ];
}
