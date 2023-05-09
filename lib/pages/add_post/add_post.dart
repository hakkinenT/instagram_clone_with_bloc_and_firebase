import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management/core/utils/show_snack_bar.dart';
import 'package:school_management/cubit/home_cubit.dart';

import '../../bloc/app_bloc.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/pick_image.dart';
import '../../cubit/post_cubit.dart';
import '../../data/models/user.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/sending_progress.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late final PostCubit postCubit;
  late final User user;

  @override
  void initState() {
    super.initState();
    postCubit = BlocProvider.of<PostCubit>(context, listen: false);
  }

  clearImage() {
    postCubit.postFileUploaded(null);
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  postCubit.postFileUploaded(file);
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  postCubit.postFileUploaded(file);
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocListener<PostCubit, PostState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          showSnackBar(context, state.errorMessage!);
        }
      },
      child: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (!state.postSent) {
            return Center(
              child: IconButton(
                onPressed: () => _selectImage(context),
                icon: const Icon(Icons.upload),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Post to'),
                leading: IconButton(
                  onPressed: () => postCubit.resetState(),
                  icon: const Icon(Icons.arrow_back),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      postCubit.postCreated(user);
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return const SendingProgress();
                      }

                      return const SizedBox(
                        height: 32,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileAvatar(
                        imageUrl: user.photoUrl ?? defaultUserImage,
                        radius: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: BlocBuilder<PostCubit, PostState>(
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: postCubit.postDescriptionChanged,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write a caption...'),
                              maxLines: 8,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: BlocBuilder<PostCubit, PostState>(
                          builder: (context, state) {
                            return AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(state.postFile!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
