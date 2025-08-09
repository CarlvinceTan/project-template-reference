import 'package:agora/features/auth/presentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:agora/features/auth/presentation/pages/index.dart';
import 'package:agora/features/dashboard/presentation/pages/dashboard_page.dart';


final GoRouter router = GoRouter (
  initialLocation: '/splash-screen',
  routes: [
    GoRoute(
      path: '/splash-screen',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const SplashScreen());
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const LoginPage());
      },
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const DashboardPage());
      },
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const SignUpPage());
      },
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const ForgotPasswordPage());
      },
    ),
    GoRoute(
      path: '/restore-password',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const RestorePasswordPage());
      },
    ),
    GoRoute(
      path: '/verify-email',
      pageBuilder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return NoTransitionPage(child: VerfiyEmailPage(email: email));
      },
    ),
  ],
);

