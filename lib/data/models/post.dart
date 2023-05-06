import 'package:equatable/equatable.dart';
import 'package:school_management/data/models/user.dart';
import 'package:uuid/uuid.dart';

class Post extends Equatable {
  final String id;
  final String description;
  final DateTime datePublished;
  final String? photoPostUrl;
  final List likes;
  final User user;

  Post({
    String? id,
    DateTime? datePublished,
    required this.description,
    this.photoPostUrl,
    this.likes = const [],
    this.user = User.empty,
  })  : id = id ?? const Uuid().v1(),
        datePublished = datePublished ?? DateTime.now();

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      description: json['description'],
      datePublished: DateTime.parse(json['datePublished'].toString()),
      photoPostUrl: json['photoPostUrl'],
      likes: json['likes'],
      user: User(
        id: json['userId'],
        username: json['username'],
        photoUrl: json['profileImage'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'datePublished': datePublished,
        'photoPostUrl': photoPostUrl,
        'likes': likes,
        'userId': user.id,
        'username': user.username,
        'profileImage': user.photoUrl,
      };

  Post copyWith({
    String? id,
    String? description,
    DateTime? datePublished,
    String? photoPostUrl,
    List? likes,
    User? user,
  }) {
    return Post(
      id: id ?? this.id,
      description: description ?? this.description,
      datePublished: datePublished ?? this.datePublished,
      photoPostUrl: photoPostUrl ?? this.photoPostUrl,
      likes: likes ?? this.likes,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        id,
        description,
        datePublished,
        photoPostUrl,
        likes,
        user,
      ];
}
