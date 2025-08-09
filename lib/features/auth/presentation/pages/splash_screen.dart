import 'package:agora/core/di/init_dependencies.dart';
import 'package:agora/features/auth/domain/use_cases/is_authenticated.dart';
import 'package:agora/shared_widgets/miscellaneous/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  bool _initializationComplete = false;
  bool _animationComplete = false;
  String? _nextRoute;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Create pulsing animation for logo glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // 6 second pulse cycle
    );

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Start initialization immediately
    _initialize();

    // Start pulsing animation with repeating pattern
    _startPulsing();

    // Set up timer for minimum splash duration
    Future.delayed(const Duration(seconds: 3), () {
      _animationComplete = true;
      _checkAndNavigate();
    });
  }

  void _startPulsing() {
    // Create continuous pulsing pattern (6 seconds per cycle)
    _pulseController.forward().then((_) {
      _pulseController.reverse().then((_) {
        // Immediately start next pulse for continuous effect
        if (mounted && !_animationComplete) {
          _startPulsing();
        }
      });
    });
  }

  Future<void> _initialize() async {
    try {
      // Check auth status
      final result = await getIt<IsAuthenticated>().call().run();
      
      result.fold(
        (failure) {
          _nextRoute = '/login';
        },
        (isAuthenticated) {
          _nextRoute = isAuthenticated ? '/dashboard' : '/login';
        },
      );
    } catch (e) {
      _nextRoute = '/login';
    }
    
    _initializationComplete = true;
    _checkAndNavigate();
  }

  void _checkAndNavigate() {
    // Only navigate when both animation and initialization are complete
    if (_initializationComplete && _animationComplete && _nextRoute != null) {
      if (mounted) {
        context.go(_nextRoute!);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
          // Background glowing circle that pulses
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              final glowIntensity = _pulseAnimation.value;
              return Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      // Brightest in center - reduced brightness
                      Theme.of(context).colorScheme.primary.withValues(alpha:
                        0.1 + (glowIntensity * 0.15) // Pulse between 10% and 25% opacity in center
                      ),
                      // Gradually dimmer towards middle
                      Theme.of(context).colorScheme.primary.withValues(alpha:
                        0.06 + (glowIntensity * 0.1) // Pulse between 6% and 16% opacity
                      ),
                      // Dimmest at edges
                      Theme.of(context).colorScheme.primary.withValues(alpha:
                        0.02 + (glowIntensity * 0.06) // Pulse between 2% and 8% opacity
                      ),
                      // Transparent at very edge
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.4, 0.7, 1.0],
                    center: Alignment.center,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha:
                        0.04 + (glowIntensity * 0.08) // Reduced shadow opacity - pulse between 4% and 12%
                      ),
                      blurRadius: 30 + (glowIntensity * 15), // Reduced blur radius
                      spreadRadius: 5 + (glowIntensity * 8), // Reduced spread radius
                    ),
                  ],
                ),
              );
            },
          ),
          // Foreground content - App icon and text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon
              AppIcon(),
              const SizedBox(height: 10),
              // App name
              Text(
                'Agora',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
