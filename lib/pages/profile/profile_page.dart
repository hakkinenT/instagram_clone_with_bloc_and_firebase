import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_bloc.dart';
import '../../core/constants/constants.dart';
import '../../data/models/user.dart';
import 'cubit/profile_cubit.dart';
import 'edit_profile_page.dart';
import 'widgets/follow_button.dart';
import '../widgets/profile_avatar.dart';
import 'widgets/profile_information.dart';
import 'widgets/user_information.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit profileCubit;
  late final User user;

  @override
  void initState() {
    super.initState();

    profileCubit = BlocProvider.of<ProfileCubit>(context, listen: false);
    user = BlocProvider.of<AppBloc>(context, listen: false).state.user;

    getUser();
  }

  void getUser() async {
    await profileCubit.userLoaded(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            title: _AppBarTitle(),
            actions: [
              _LogoutButton(),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: _ProfilePageHeader(user: user),
            ),
          ),
          //fim
          const SliverToBoxAdapter(child: Divider()),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 1.5,
              childAspectRatio: 1,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return const Image(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1682621421157-8e39b469a206?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
                fit: BoxFit.cover,
              );
            },
          )
        ],
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Text(state.username ?? '');
      },
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<AppBloc>(context).add(const AppLogoutRequested());
      },
      icon: const Icon(Icons.logout_outlined),
    );
  }
}

class _ProfilePageHeader extends StatelessWidget {
  const _ProfilePageHeader({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const _ProfilePicture(),
            Expanded(
              child: _ProfileInformationPanel(user: user),
            ),
          ],
        ),
        const _UserUsernameInformation(),
        const _UserBioInformation(),
      ],
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return state.photoUrl != null
            ? ProfileAvatar(
                imageUrl: state.photoUrl!,
              )
            : const ProfileAvatar(imageUrl: defaultUserImage);
      },
    );
  }
}

class _ProfileInformationPanel extends StatelessWidget {
  const _ProfileInformationPanel({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ProfileInformations(),
        _ProfileButtons(user: user),
      ],
    );
  }
}

class _ProfileInformations extends StatelessWidget {
  const _ProfileInformations();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Information(
              label: 'posts',
              quantity: 100,
            ),
            Information(
              label: 'followers',
              quantity: state.followers,
            ),
            Information(
              label: 'following',
              quantity: state.following,
            ),
          ],
        );
      },
    );
  }
}

class _ProfileButtons extends StatelessWidget {
  const _ProfileButtons({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FollowButton(
          text: 'Edit Profile',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          borderColor: Colors.grey,
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditProfilePage(
                  user: user,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _UserUsernameInformation extends StatelessWidget {
  const _UserUsernameInformation();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return UserInformation(
          topSpacing: 15,
          text: state.username ?? 'username',
        );
      },
    );
  }
}

class _UserBioInformation extends StatelessWidget {
  const _UserBioInformation();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return UserInformation(
          topSpacing: 2,
          text: state.bio ?? '',
        );
      },
    );
  }
}
