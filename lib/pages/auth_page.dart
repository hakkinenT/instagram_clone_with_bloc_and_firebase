import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/pages/home/home_page.dart';
import 'package:school_management/pages/login/login_page.dart';

import '../bloc/app_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.status == AppStatus.authenticated) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
