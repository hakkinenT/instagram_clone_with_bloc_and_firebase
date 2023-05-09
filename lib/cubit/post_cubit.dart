import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:school_management/data/models/form/post_description.dart';
import 'package:school_management/data/repositories/interfaces/comment_repository.dart';
import 'package:school_management/data/repositories/interfaces/post_repository.dart';

import '../data/models/comment.dart';
import '../data/models/form/comment.dart';
import '../data/models/post.dart';
import '../data/models/user.dart';

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

  void likePost(Post post, String followId) async {
    final likePostOrFailure = await postRepository.likePost(post, followId);

    likePostOrFailure.fold(
      (failure) => emit(
        state.copyWith(
            status: PostStatus.failure, errorMessage: failure.message),
      ),
      (success) => emit(
        state.copyWith(status: PostStatus.success),
      ),
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
