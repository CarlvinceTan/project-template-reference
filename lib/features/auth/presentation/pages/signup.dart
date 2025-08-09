import 'package:agora/features/auth/presentation/widgets/auth_button.dart';
import 'package:agora/shared_widgets/miscellaneous/app_icon.dart';
import 'package:agora/shared_widgets/miscellaneous/loader.dart';
import 'package:agora/core/utils/show_snackbar.dart';
import 'package:agora/core/utils/validators.dart';
import 'package:agora/core/utils/widget_modifiers.dart';
import 'package:agora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/index.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
            Text("Sign Up", style: Theme.of(context).textTheme.displayLarge),
            Text(
              "Create an account to get started with Agora",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthEmailVerificationRequired) {
                  showSnackBar(context, 'Account created! Please check your email for verification.');
                  context.go('/verify-email?email=${state.email}');
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
                      AuthField(
                        hintText: "Confirm Password",
                        controller: confirmPasswordController,
                        isObscureText: true,
                        validator:
                            (value) => validateConfirmPassword(
                              value,
                              passwordController.text,
                            ),
                      ),
                      // Conditional rendering based on state
                      if (state is AuthLoading)
                        const Loader()
                      else
                        AuthButton(
                          text: "Sign Up",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthSignUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                        ),
                    ].divide(SizedBox(height: 10)),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SectionDivider(text: "Or sign up with"),
            SizedBox(height: 18),
            ThirdPartyAuth(),
            SizedBox(height: 40),
            SwitchAuth(
              promptText: "Already have an account?",
              linkText: "Login here",
              onTap: () => context.go('/login'),
            ),
          ].divide(SizedBox(height: 10)),
        ),
      ),
    );
  }
}