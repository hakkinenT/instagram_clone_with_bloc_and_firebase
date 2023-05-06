import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/pick_image.dart';
import '../../core/utils/show_snack_bar.dart';
import '../../data/models/user.dart';
import '../widgets/custom/custom_text_form_field.dart';
import '../widgets/sending_progress.dart';
import 'cubit/profile_cubit.dart';
import 'widgets/edit_profile_avatar.dart';
import 'widgets/picker_photo_button.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();

    profileCubit = BlocProvider.of<ProfileCubit>(context, listen: false);
  }

  void selectImage() async {
    final image = await pickImage(ImageSource.gallery);
    profileCubit.photoFileUploaded(image);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          showSnackBar(context, 'Usuário atualizado com sucesso!');
          Navigator.pop(context);
        }

        if (state.status.isFailure) {
          showSnackBar(context, state.errorMessage!);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await profileCubit.userUpdated(widget.user);
              },
              icon: const Icon(
                Icons.check,
                //color: blueColor,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16.0),
          child: Column(
            children: [
              const _ProfileProgress(),
              const _ProfilePicture(),
              PickerPhotoButton(
                onPressed: selectImage,
              ),
              const SizedBox(
                height: 16,
              ),
              const _UsernameField(),
              const SizedBox(
                height: 8,
              ),
              const _BioField()
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileProgress extends StatelessWidget {
  const _ProfileProgress();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const SendingProgress();
        }

        return const SizedBox();
      },
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: state.photoFile != null
              ? EditProfileAvatar(
                  backgroundImage: MemoryImage(state.photoFile!),
                )
              : EditProfileAvatar(
                  backgroundImage:
                      NetworkImage(state.photoUrl ?? defaultUserImage),
                ),
        );
      },
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('usernameField_editProfile'),
          initialValue: state.username,
          onChanged: BlocProvider.of<ProfileCubit>(context).usernameChanged,
          labelText: 'Username',
          hintText: 'Username',
        );
      },
    );
  }
}

class _BioField extends StatelessWidget {
  const _BioField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('bioField_editProfile'),
          initialValue: state.bio,
          onChanged: BlocProvider.of<ProfileCubit>(context).bioChanged,
          labelText: 'Bio',
          hintText: 'Bio',
        );
      },
    );
  }
}
