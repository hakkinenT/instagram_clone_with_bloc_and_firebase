import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/show_snack_bar.dart';
import '../../cubit/post_cubit.dart';

import 'widgets/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    getPosts();
  }

  getPosts() async {
    await BlocProvider.of<PostCubit>(context).postsFetched();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          instagramImage,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline),
          ),
        ],
      ),
      body: BlocListener<PostCubit, PostState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            showSnackBar(context, state.errorMessage!);
          }
        },
        child: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final posts = state.posts;

          if (posts.isEmpty) {
            return const Center(
              child: Text('não há posts'),
            );
          }

          return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: posts[index]);
              });
        }),
      ),
    );
  }
}
