import 'package:agora/shared_widgets/miscellaneous/app_icon.dart';
import 'package:agora/shared_widgets/miscellaneous/loader.dart';
import 'package:agora/core/utils/show_snackbar.dart';
import 'package:agora/core/utils/validators.dart';
import 'package:agora/core/utils/widget_modifiers.dart';
import 'package:agora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora/features/auth/presentation/widgets/index.dart';
import 'package:agora/features/auth/presentation/widgets/auth_button.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 40,
          bottom: 0.0,
          left: 40,
          right: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppIcon(),
            Text("Login", style: Theme.of(context).textTheme.displayMedium),
            Text("Welcome back!", style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 0),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthSuccess) {
                  showSnackBar(context, 'Login successful!');
                  context.go('/dashboard');
                }
              },
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AuthField(
                        hintText: "Email",
                        controller: emailController,
                        validator: (value) => validateEmail(value),
                      ),
                      AuthField(
                        hintText: "Password",
                        controller: passwordController,
                        isObscureText: true,
                        validator: (value) => validateSimplePassword(value),
                      ),
                      if (state is AuthLoading)
                        const Loader()
                      else
                        AuthButton(
                          text: "Login",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthLogin(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                        ),
                      GestureDetector(
                        onTap: () => context.go('/forgot-password'),
                        child: Text(
                          "Forgot password?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ].divide(SizedBox(height: 10))
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SectionDivider(text: "Or login with"),
            SizedBox(height: 18),
            ThirdPartyAuth(),
            SizedBox(height: 40),
            SwitchAuth(
              promptText: "Don't have an account?",
              linkText: "Sign up here",
              onTap: () => context.go('/signup'),
            ),
          ].divide(SizedBox(height: 10))
        ),
      ),
    );
  }
}