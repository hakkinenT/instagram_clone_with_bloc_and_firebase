part of 'post_cubit.dart';

enum PostStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == PostStatus.initial;
  bool get isLoading => this == PostStatus.loading;
  bool get isSuccess => this == PostStatus.success;
  bool get isFailure => this == PostStatus.failure;
}

class PostState extends Equatable {
  final Uint8List? postFile;
  final bool isLikeAnimating;
  final List<Comment> comments;
  final List<Post> posts;
  final CommentText commentText;
  final PostDescription postDescription;
  final PostStatus status;
  final String? errorMessage;
  final bool postSent;
  final bool postLiked;

  const PostState(
      {this.postFile,
      this.isLikeAnimating = false,
      this.comments = const [],
      this.posts = const [],
      this.commentText = const CommentText(''),
      this.postDescription = const PostDescription(''),
      this.status = PostStatus.initial,
      this.postSent = false,
      this.postLiked = false,
      this.errorMessage});

  PostState copyWith({
    Uint8List? postFile,
    bool? isLikeAnimating,
    List<Comment>? comments,
    List<Post>? posts,
    CommentText? commentText,
    PostDescription? postDescription,
    PostStatus? status,
    String? errorMessage,
    bool? postSent,
    bool? postLiked,
  }) {
    return PostState(
      postFile: postFile ?? this.postFile,
      isLikeAnimating: isLikeAnimating ?? this.isLikeAnimating,
      comments: comments ?? this.comments,
      posts: posts ?? this.posts,
      commentText: commentText ?? this.commentText,
      postDescription: postDescription ?? this.postDescription,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      postSent: postSent ?? this.postSent,
      postLiked: postLiked ?? this.postLiked,
    );
  }

  @override
  List<Object?> get props => [
        postFile,
        isLikeAnimating,
        comments,
        posts,
        commentText,
        postDescription,
        status,
        errorMessage,
        postSent,
        postLiked,
      ];
}
