import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

/// Premium animated splash screen for TechZone eCommerce app
/// Features gradient background, glowing logo, animated text, and smooth transitions
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation controllers for various animations
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particlesController;
  late AnimationController _loadingController;

  // Animation objects
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<double> _loadingRotationAnimation;

  // Timer for navigation
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _scheduleNavigation();
  }

  /// Initialize all animation controllers and animations
  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Particles animation controller
    _particlesController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Loading indicator animation controller
    _loadingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Logo scale and opacity animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Text animations
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
    ));

    _textSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
    ));

    // Loading rotation animation
    _loadingRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_loadingController);
  }

  /// Start all animations in sequence
  void _startAnimations() {
    // Start logo animation immediately
    _logoController.forward();

    // Start text animation after logo starts
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _textController.forward();
      }
    });

    // Particles are rendered static to avoid background movement

    // Start loading animation
    _loadingController.repeat();
  }

  /// Schedule navigation to onboarding after 3 seconds
  void _scheduleNavigation() {
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _navigateToOnboarding();
      }
    });
  }

  /// Navigate to onboarding with smooth transition
  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacementNamed('/onboarding');
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _particlesController.dispose();
    _loadingController.dispose();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient layer
          _buildGradientBackground(),

          // Floating particles layer
          _buildFloatingParticles(),

          // Main content layer
          _buildMainContent(),

          // Advertisement box with CTA button at the bottom
          _buildAdBox(),
        ],
      ),
    );
  }

  /// Build the gradient background from deep blue to teal
  Widget _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2027), // Deep blue
            Color(0xFF2C5364), // Teal
          ],
          stops: [0.0, 1.0],
        ),
      ),
    );
  }

  /// Build advertisement box with CTA button at the bottom
  Widget _buildAdBox() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final card = Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Ad text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Exclusive Tech Deals',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Save up to 40% on top gadgets today.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildCtaButton(),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Exclusive Tech Deals',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Save up to 40% on top gadgets today.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildCtaButton(),
                        ],
                      ),
              );

              // Static card to avoid any perceived background movement
              return card;
            },
          ),
        ),
      ),
    );
  }

  /// Build the CTA button that navigates to onboarding and cancels timer
  Widget _buildCtaButton() {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          // Cancel scheduled navigation to avoid double push
          _navigationTimer?.cancel();
          _navigateToOnboarding();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF20C997), // teal accent
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: const Text(
          'Next',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// Build floating particles for depth effect
  Widget _buildFloatingParticles() {
    // Render a static particles layer (no animation) to prevent screen movement
    return CustomPaint(
      painter: ParticlesPainter(0.0),
      size: MediaQuery.of(context).size,
    );
  }

  /// Build the main content (logo, text, loading indicator)
  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Glowing logo area
          _buildGlowingLogo(),

          const SizedBox(height: 40),

          // Animated welcome text
          _buildAnimatedText(),

          const SizedBox(height: 60),

          // Loading indicator
          _buildLoadingIndicator(),
        ],
      ),
    );
  }

  /// Build the glowing circular logo with TZ monogram
  Widget _buildGlowingLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScaleAnimation.value,
          child: Opacity(
            opacity: _logoOpacityAnimation.value,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
                boxShadow: [
                  // Outer glow effect
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                  // Inner glow
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'TZ',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                      Shadow(
                        color: Colors.cyan.withOpacity(0.5),
                        offset: const Offset(0, 0),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build animated welcome text
  Widget _buildAnimatedText() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _textSlideAnimation.value),
          child: Opacity(
            opacity: _textOpacityAnimation.value,
            child: Text(
              'Welcome to TechZone',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build custom loading indicator
  Widget _buildLoadingIndicator() {
    return AnimatedBuilder(
      animation: _loadingController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _loadingRotationAnimation.value * 2 * math.pi,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: CustomPaint(
              painter: LoadingIndicatorPainter(_loadingController.value),
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter for floating particles
class ParticlesPainter extends CustomPainter {
  final double animationValue;

  ParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Create multiple floating particles
    for (int i = 0; i < 8; i++) {
      final angle = (animationValue * 2 * math.pi) + (i * math.pi / 4);
      final radius = 50 + (i * 20);
      final x = size.width / 2 + radius * math.cos(angle);
      final y = size.height / 2 + radius * math.sin(angle);

      // Vary particle size and opacity
      final particleSize = 2 + (i % 3);
      final opacity = 0.1 + (math.sin(angle + animationValue * math.pi) * 0.1);

      canvas.drawCircle(
        Offset(x, y),
        particleSize.toDouble(),
        Paint()
          ..color = Colors.white.withOpacity(opacity.clamp(0.0, 0.3))
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for loading indicator
class LoadingIndicatorPainter extends CustomPainter {
  final double animationValue;

  LoadingIndicatorPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 4) / 2;

    // Draw animated arc
    final startAngle = -math.pi / 2;
    final sweepAngle = math.pi * 1.5 * animationValue;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = Colors.white.withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
