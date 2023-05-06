import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? username;
  final String? photoUrl;
  final String? biography;
  final List? followers;
  final List? following;

  const User({
    required this.id,
    this.email,
    this.username,
    this.photoUrl,
    this.biography,
    this.followers,
    this.following,
  });

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        photoUrl: json['photoUrl'],
        biography: json['biography'],
        followers: json['followers'],
        following: json['following']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'photoUrl': photoUrl,
        'biography': biography,
        'followers': followers,
        'following': following,
      };

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? photoUrl,
    String? biography,
    List? followers,
    List? following,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
      biography: biography ?? this.biography,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  @override
  List<Object?> get props =>
      [id, email, username, photoUrl, biography, followers, following];
}
