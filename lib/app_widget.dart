import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc.dart';
import 'cubit/home_cubit.dart';
import 'cubit/post_cubit.dart';
import 'injection_container.dart';
import 'pages/auth_page.dart';
import 'pages/profile/cubit/profile_cubit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: sl<AppBloc>(),
        ),
        BlocProvider.value(
          value: sl<ProfileCubit>(),
        ),
        BlocProvider.value(
          value: sl<PostCubit>(),
        ),
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
    );
  }
}
