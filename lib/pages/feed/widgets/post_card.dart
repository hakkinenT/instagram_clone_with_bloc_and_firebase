import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/app_bloc.dart';
import '../../../core/constants/constants.dart';
import '../../../cubit/post_cubit.dart';
import '../../../data/models/post.dart';
import '../../../data/models/user.dart';
import '../../widgets/profile_avatar.dart';
import 'like_animation.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late final PostCubit postCubit;
  late final User user;

  @override
  void initState() {
    super.initState();
    postCubit = BlocProvider.of<PostCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    user = BlocProvider.of<AppBloc>(context).state.user;
    getLikes();
  }

  getLikes() async {
    await postCubit.postLikes(widget.post.id, user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: mobileBackgroundColor,
        border: Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                ProfileAvatar(
                  imageUrl: widget.post.user.photoUrl ?? defaultUserImage,
                  radius: 16,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.user.username ?? 'username',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map((e) => InkWell(
                                    onTap: () async {
                                      //delete
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Text(e),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              postCubit
                ..likePost(widget.post, user.id)
                ..likeAnimationChanged();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: InteractiveViewer(
                    //!Melhorar isso aqui
                    maxScale: 4,
                    boundaryMargin: EdgeInsets.zero,
                    child: Image.network(
                      widget.post.photoPostUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                BlocBuilder<PostCubit, PostState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: state.isLikeAnimating ? 1 : 0,
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      child: LikeAnimation(
                        isAnimating: state.isLikeAnimating,
                        onEnd: () {
                          postCubit.likeAnimationChanged();
                        },
                        child: const Icon(Icons.favorite,
                            color: Colors.white, size: 120),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14),
            child: Row(
              children: [
                BlocBuilder<PostCubit, PostState>(
                  builder: (context, state) {
                    return LikeAnimation(
                      isAnimating: state.postLiked, //mudar
                      smallLike: true,

                      child: IconButton(
                        icon: state.postLiked
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite_border),
                        onPressed: () {
                          postCubit.likePost(widget.post, user.id);
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    //ir para a comment screen
                  },
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_border,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                  child: Text(
                    '${widget.post.likes.length} likes',
                    //style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.post.user.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.post.description}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: Text(
                      'View all 100 comments',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(widget.post.datePublished),
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
