import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/show_snack_bar.dart';
import '../../injection_container.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../widgets/button_link.dart';
import '../widgets/custom/custom_elevated_button.dart';
import '../widgets/custom/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import '../widgets/instagram_logo.dart';
import '../widgets/or_divider_widget.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider.value(
          value: sl<SignUpCubit>(),
          child: const SignUpForm(),
        ),
      ),
      bottomNavigationBar: const _GoToLoginPageButton(),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeView(),
            ),
          );
        }
        if (state.status.isFailure) {
          showSnackBar(context, state.errorMessage ?? 'Authentication Failure');
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
                const SizedBox(
                  height: 32,
                ),
                _NameInput(),
                const SizedBox(
                  height: 16,
                ),
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

class _GoToLoginPageButton extends StatelessWidget {
  const _GoToLoginPageButton();

  @override
  Widget build(BuildContext context) {
    return ButtonLink(
      text: 'Have an account?',
      linkText: 'Log in',
      onLinkTapped: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return CustomTextFormField(
        key: const Key('signUpForm_usernameInput_textField'),
        outlinedBorder: true,
        onChanged: (username) =>
            context.read<SignUpCubit>().usernameChanged(username),
        textInputAction: TextInputAction.next,
        validator: (_) => state.username.validator(),
        hintText: 'Enter your username',
      );
    });
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return CustomTextFormField(
        key: const Key('signUpForm_emailInput_textField'),
        outlinedBorder: true,
        onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return CustomTextFormField(
        key: const Key('signUpForm_passwordInput_textField'),
        outlinedBorder: true,
        onChanged: (password) =>
            context.read<SignUpCubit>().passwordChanged(password),
        validator: (_) => state.password.validator(),
        obscureText: state.obscurePassword,
        hintText: 'Enter your password',
        textInputAction: TextInputAction.done,
        onFiledSubmitted: (_) {
          FocusScope.of(context).unfocus();
        },
        suffixIcon: IconButton(
          onPressed: () {
            context.read<SignUpCubit>().obscureText();
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
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return CustomElevatedButton(
        key: const Key('signUpForm_continue_raisedButton'),
        onPressed: state.status.isValidated
            ? () => context.read<SignUpCubit>().signUpFormSubmitted()
            : null,
        child: state.status.isLoading
            ? const CircularProgressIndicator()
            : const Text('Sign up'),
      );
    });
  }
}
