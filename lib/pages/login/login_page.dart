import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/show_snack_bar.dart';
import '../../injection_container.dart';
import '../sign_up/sign_up_page.dart';
import '../widgets/instagram_logo.dart';
import '../widgets/button_link.dart';
import '../widgets/custom/custom_elevated_button.dart';
import '../widgets/custom/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import '../widgets/or_divider_widget.dart';
import 'cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider.value(
            value: sl<LoginCubit>(),
            child: const LoginForm(),
          ),
        ),
        bottomNavigationBar: const _GoToSignUpPage());
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          showSnackBar(context, state.errorMessage ?? 'Authentication Failre');
        }
      },
      child: SafeArea(
        child: Align(
          alignment: const Alignment(0, 1 / 3),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const InstagramLogo(),
                const SizedBox(height: 40),
                _EmailInput(),
                const SizedBox(
                  height: 16,
                ),
                _PasswordInput(),
                const SizedBox(
                  height: 16,
                ),
                _LoginButton(),
                const SizedBox(
                  height: 24,
                ),
                const OrDividerWidget(),
                const SizedBox(
                  height: 24,
                ),
                const GoogleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoToSignUpPage extends StatelessWidget {
  const _GoToSignUpPage();

  @override
  Widget build(BuildContext context) {
    return ButtonLink(
      text: 'Don\'t have an account?',
      linkText: 'Sign up',
      onLinkTapped: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const SignUpPage(),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return CustomTextFormField(
        key: const Key('loginForm_emailInput_textField'),
        outlinedBorder: true,
        onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (_) => state.email.validator(),
        hintText: 'Enter your email',
      );
    });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return CustomTextFormField(
        key: const Key('loginForm_passwordInput_textField'),
        outlinedBorder: true,
        onChanged: (password) =>
            context.read<LoginCubit>().passwordChanged(password),
        validator: (_) => state.password.validator(),
        obscureText: state.obscurePassword,
        hintText: 'Enter your password',
        textInputAction: TextInputAction.done,
        onFiledSubmitted: (_) {
          FocusScope.of(context).unfocus();
        },
        suffixIcon: IconButton(
          onPressed: () {
            context.read<LoginCubit>().obscureText();
          },
          icon: state.obscurePassword
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      );
    });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return CustomElevatedButton(
        key: const Key('loginForm_continue_raisedButton'),
        onPressed: state.status.isValidated
            ? () => context.read<LoginCubit>().logInWithCredentials()
            : null,
        child: state.status.isLoading
            ? const CircularProgressIndicator()
            : const Text('Log in'),
      );
    });
  }
}
