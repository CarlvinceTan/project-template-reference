import 'package:agora/features/auth/presentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:agora/features/auth/presentation/pages/index.dart';
import 'package:agora/features/dashboard/presentation/pages/dashboard_page.dart';


final GoRouter router = GoRouter (
  initialLocation: '/splash-screen',
  routes: [
    GoRoute(
      path: '/splash-screen',
      builder: (context, state) => const SplashScreen(),
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const SplashScreen());
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const LoginPage());
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const DashboardPage());
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const SignUpPage());
      },
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const ForgotPasswordPage());
      },
    ),
    GoRoute(
      path: '/restore-password',
      builder: (context, state) => const RestorePasswordPage(),
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const RestorePasswordPage());
      },
    ),
    GoRoute(
      path: '/verify-email',
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return VerfiyEmailPage(email: email);
      },
      pageBuilder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return NoTransitionPage(child: VerfiyEmailPage(email: email));
      },
    ),
  ],
);

