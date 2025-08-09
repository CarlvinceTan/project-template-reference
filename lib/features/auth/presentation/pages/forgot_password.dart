import 'package:agora/core/utils/validators.dart';
import 'package:agora/core/utils/widget_modifiers.dart';
import 'package:agora/core/utils/show_snackbar.dart';
import 'package:agora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:agora/features/auth/presentation/widgets/auth_button.dart';
import 'package:agora/features/auth/presentation/widgets/auth_field.dart';
import 'package:agora/features/auth/presentation/widgets/return_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthRestorePassword(email: emailController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            showSnackBar(context, 'Password reset email sent successfully!');
            context.go('/login');
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          
          return Padding(
            padding: EdgeInsets.only(
              top: 40.0, 
              bottom: 0.0,
              left: 40.0, 
              right: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Column(
                  children: [
                    Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No worries, enter the email you've registered with us and we'll send you the reset instructions",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AuthField(
                        hintText: "Email", 
                        controller: emailController,
                        validator: (value) => validateEmail(value),
                      ),
                      AuthButton(
                        text: isLoading ? "Sending..." : "Send",
                        onPressed: isLoading ? null : _sendResetEmail,
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: ReturnButton(text: "Back to Login")
                ),
              ].divide(SizedBox(height: 10)),
            )
          );
        },
      ),
    );
  }
}