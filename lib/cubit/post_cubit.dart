import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../data/models/comment.dart';
import '../data/models/form/comment.dart';
import '../data/models/form/post_description.dart';
import '../data/models/post.dart';
import '../data/models/user.dart';
import '../data/repositories/interfaces/comment_repository.dart';
import '../data/repositories/interfaces/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository postRepository;
  final CommentRepository commentRepository;

  PostCubit({required this.postRepository, required this.commentRepository})
      : super(const PostState());

  void commentTextChanged(String value) {
    final comment = CommentText(value);

    emit(state.copyWith(commentText: comment));
  }

  void postDescriptionChanged(String value) {
    final description = PostDescription(value);

    emit(state.copyWith(postDescription: description));
  }

  void postFileUploaded(Uint8List? postFile) {
    emit(state.copyWith(postFile: postFile, postSent: true));
  }

  void likeAnimationChanged() {
    emit(state.copyWith(isLikeAnimating: !state.isLikeAnimating));
  }

  postsFetched() async {
    emit(state.copyWith(status: PostStatus.loading));

    final postsOrFailure = await postRepository.getAllPosts();

    postsOrFailure.fold(
      (failure) => emit(state.copyWith(
          status: PostStatus.failure, errorMessage: failure.message)),
      (posts) => emit(state.copyWith(posts: posts, status: PostStatus.success)),
    );
  }

  postsFetchedByUserId(String userId) async {
    emit(state.copyWith(status: PostStatus.loading));

    final postsOrFailure = await postRepository.getPostByUserId(userId);

    postsOrFailure.fold(
      (failure) => emit(state.copyWith(
          status: PostStatus.failure, errorMessage: failure.message)),
      (posts) => emit(state.copyWith(posts: posts, status: PostStatus.success)),
    );
  }

  void postCreated(User user) async {
    final post = Post(description: state.postDescription.value, user: user);

    final createPostOrFailure =
        await postRepository.uploadPost(post, state.postFile);

    createPostOrFailure.fold(
      (failure) => emit(
        state.copyWith(
            status: PostStatus.failure, errorMessage: failure.message),
      ),
      (success) async {
        await postsFetched();
        emit(
          state.copyWith(
            postSent: false,
          ),
        );
      },
    );
  }

  postLikes(String postId, String userId) async {
    final likesOrFailure = await postRepository.getPostLikes(postId);

    likesOrFailure.fold(
        (failure) => emit(
              state.copyWith(
                  status: PostStatus.failure, errorMessage: failure.message),
            ),
        (likes) => emit(state.copyWith(
              postLiked: likes.contains(userId),
            )));
  }

  void likePost(Post post, String followId) async {
    final likePostOrFailure = await postRepository.likePost(post, followId);

    likePostOrFailure.fold(
      (failure) => emit(
        state.copyWith(
            status: PostStatus.failure, errorMessage: failure.message),
      ),
      (success) async {
        await postLikes(post.id, followId);
        print(state.postLiked);
      },
    );
  }

  resetState() {
    Uint8List? postFile;
    emit(state.copyWith(
        postFile: postFile,
        isLikeAnimating: false,
        comments: const [],
        posts: const [],
        commentText: const CommentText(''),
        postDescription: const PostDescription(''),
        status: PostStatus.initial,
        postSent: false,
        errorMessage: null));
  }
}
