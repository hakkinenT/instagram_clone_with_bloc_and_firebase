import 'package:equatable/equatable.dart';

import 'package:uuid/uuid.dart';

import 'post.dart';
import 'user.dart';

class Comment extends Equatable {
  final String id;
  final String text;
  final DateTime datePublished;
  final User user;
  final Post? post;

  Comment({
    String? id,
    DateTime? datePublished,
    required this.text,
    required this.user,
    this.post,
  })  : id = id ?? const Uuid().v1(),
        datePublished = datePublished ?? DateTime.now();

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      datePublished: DateTime.parse(json['datePublished'].toString()),
      user: User(
        id: json['userId'],
        username: json['username'],
        photoUrl: json['profileImage'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'datePublished': datePublished,
        'userId': user.id,
        'username': user.username,
        'profileImage': user.photoUrl,
      };

  Comment copyWith({
    String? id,
    String? text,
    DateTime? datePublished,
    User? user,
    Post? post,
  }) {
    return Comment(
      id: id ?? this.id,
      text: text ?? this.text,
      datePublished: datePublished ?? this.datePublished,
      user: user ?? this.user,
      post: post ?? this.post,
    );
  }

  @override
  List<Object?> get props => [
        id,
        text,
        datePublished,
        user,
        post,
      ];
}
