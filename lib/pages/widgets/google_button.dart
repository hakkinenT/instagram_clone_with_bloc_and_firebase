import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_management/core/constants/constants.dart';

import '../../injection_container.dart';
import '../login/cubit/login_cubit.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: GoogleSignInLink(
        onTap: () {
          context.read<LoginCubit>().logInWithGoogle();
        },
      ),
    );
  }
}

class GoogleSignInLink extends StatelessWidget {
  final VoidCallback onTap;
  const GoogleSignInLink({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            googleImage,
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            'Log in with Google',
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
