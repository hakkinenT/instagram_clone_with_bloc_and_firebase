import 'package:go_router/go_router.dart';

import '../bloc/app_bloc.dart';
import '../injection_container.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/sign_up/sign_up_page.dart';
import 'routes_name.dart';

final bloc = sl<AppBloc>();

final GoRouter routerConfig = GoRouter(
  initialLocation: loginPage,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    bool isLoggedIn = bloc.state.status == AppStatus.authenticated;
    bool isLoggingIn = state.location == loginPage;

    if (!isLoggingIn && !isLoggedIn) return loginPage;
    if (isLoggedIn && isLoggingIn) return '/';

    return null;
  },
);
