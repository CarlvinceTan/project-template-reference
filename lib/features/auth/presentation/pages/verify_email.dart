import 'package:agora/core/utils/widget_modifiers.dart';
import 'package:agora/core/utils/show_snackbar.dart';
import 'package:agora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:agora/features/auth/presentation/widgets/auth_button.dart';
import 'package:agora/features/auth/presentation/widgets/return_button.dart';
import 'package:agora/features/auth/presentation/widgets/token_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerfiyEmailPage extends StatefulWidget {
  final String email;
  
  const VerfiyEmailPage({super.key, required this.email});

  @override
  State<VerfiyEmailPage> createState() => _VerfiyEmailPageState();
}

class _VerfiyEmailPageState extends State<VerfiyEmailPage> {
  final tokenController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    tokenController.dispose();
    super.dispose();
  }

  void _verifyEmail(String verificationCode) {
    if (_disposed || !mounted) return;
    if (verificationCode.length == 6) {
      context.read<AuthBloc>().add(
        AuthVerifyEmail(
          email: widget.email,
          verificationCode: verificationCode,
        ),
      );
    }
  }

  void _resendVerification() {
    if (_disposed || !mounted) return;
    context.read<AuthBloc>().add(
      AuthResendVerification(email: widget.email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthSuccess) {
          showSnackBar(context, 'Email verified successfully!');
          context.go('/dashboard');
        } else if (state is AuthEmailVerificationRequired) {
          showSnackBar(context, 'Verification email sent! Please check your inbox.');
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        
        return Scaffold(
          body: Padding(
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
                      "Email Verification",
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height:10
                    ),
                    Text(
                      "Please check your inbox and junk mail for instructions to verify your email",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TokenField(
                        onCompleted: _verifyEmail,
                        controller: tokenController,
                      ),
                      AuthButton(
                        text: isLoading ? "Sending..." : "Resend Code", 
                        onPressed: isLoading ? null : _resendVerification,
                      ),
                    ].divide(SizedBox(height: 10)),
                  )
                ),
                GestureDetector(
                  onTap: () => context.go('/signup'),
                  child: ReturnButton(text: "Back to Signup")
                ),
              ].divide(SizedBox(height: 10)),
            )
          )
        );
      },
    );
  }
}