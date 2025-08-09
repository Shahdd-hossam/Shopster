import 'package:flutter/material.dart';
import 'package:new_task/presentation/features/auth/sign_up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _logoController;
  late Animation<double> _progressAnimation;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    
    try {
      _logoController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      );
      
      _progressController = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this,
      );

      _logoAnimation = CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
      );

      _progressAnimation = CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      );

      // Start animations after widget is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _startAnimations();
        }
      });
    } catch (e) {
      debugPrint('Splash screen initialization error: $e');
    }
  }

  void _startAnimations() async {
    try {
      // Start logo animation
      await _logoController.forward();
      
      // Wait a bit then start progress animation
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        await _progressController.forward();
      }
      
      // Navigate to main app after splash duration
      await Future.delayed(const Duration(milliseconds: 2500));
      if (mounted && context.mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SignUpScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      // Handle any animation errors gracefully
      debugPrint('Splash screen animation error: $e');
      if (mounted && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    try {
      _logoController.dispose();
      _progressController.dispose();
    } catch (e) {
      debugPrint('Splash screen dispose error: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      size: 60,
                      color: Colors.teal,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 30),
            
            // Welcome Text
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _logoAnimation.value,
                  child: const Column(
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Shopping App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 60),
            
            // Progress Bar
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Column(
                  children: [
                    Container(
                      width: 250,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: 250 * _progressAnimation.value,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading your experience...',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
