import 'package:agora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dashboard,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to Dashboard!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You are successfully authenticated.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthLogout());
                context.go('/login');
              }, 
              child: const Text('Logout')
            )
          ],
        ),
      ),
    );
  }
}
