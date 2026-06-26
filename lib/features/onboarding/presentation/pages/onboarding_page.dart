import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final AnimationController _animCtrl;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  final List<_OnboardingItem> _pages = const [
    _OnboardingItem(
      image: 'assets/onboarding/1stonbaoidng .jpg',
      title: 'Karibu Xerin',
      description:
          'Pata bidhaa bora na bei nafuu. Tembelea maduka yote kutoka kifaa chako.',
    ),
    _OnboardingItem(
      image: 'assets/onboarding/deliveryobaording.jpg',
      title: 'Usafiri Haraka',
      description:
          'Pokea oda zako haraka zaidi. Tunaenda kwa wateja wote kwa muda mfupi.',
    ),
    _OnboardingItem(
      image: 'assets/onboarding/securepayemtbns.jpg',
      title: 'Malipo Salama',
      description:
          'Lipa kwa usalama kamili. Data na malipo yako yanatazamwa vizuri.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    _animCtrl.forward(from: 0);
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkip() {
    context.go(AppConstants.signInRoute);
  }

  void _onGetStarted() {
    context.go(AppConstants.signInRoute);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 6,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) =>
                      _buildTopSection(_pages[index], colorScheme),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -50),
                child: _buildBottomSection(colorScheme),
              ),
            ],
          ),
          if (_currentPage < _pages.length - 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child: TextButton(
                onPressed: _onSkip,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopSection(_OnboardingItem item, ColorScheme colorScheme) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image fills the entire top section
        Image.asset(
          item.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        // Soft gradient overlay for smooth transition to bottom
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.05),
                Colors.transparent,
                Colors.black.withOpacity(0.15),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(ColorScheme colorScheme) {
    final isLast = _currentPage == _pages.length - 1;

    return ClipPath(
      clipper: _UpwardCurveClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(32, 60, 32, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          SlideTransition(
            position: _slideAnim,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                children: [
                  Text(
                    _pages[_currentPage].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      _pages[_currentPage].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: colorScheme.onSurface.withValues(alpha: 0.55),
                        height: 1.6,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                _pages.length,
                (index) => _buildDot(index, colorScheme),
              ),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                GestureDetector(
                  onTap: _onBack,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.surface,
                      border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: colorScheme.primary,
                      size: 22,
                    ),
                  ),
                )
              else
                const SizedBox(width: 52),
              if (!isLast)
                GestureDetector(
                  onTap: _onNext,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: AnimatedArrow(color: colorScheme.onPrimary),
                  ),
                )
              else
                GestureDetector(
                  onTap: _onGetStarted,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary,
                          colorScheme.primary.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildDot(int index, ColorScheme colorScheme) {
    final isActive = index == _currentPage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 30 : 8,
      height: 8,
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.6),
                ],
              )
            : LinearGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.2),
                  colorScheme.primary.withValues(alpha: 0.2),
                ],
              ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _OnboardingItem {
  final String image;
  final String title;
  final String description;

  const _OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 50)
      ..cubicTo(
        size.width * 0.15,
        size.height - 10,
        size.width * 0.35,
        size.height + 10,
        size.width * 0.5,
        size.height - 15,
      )
      ..cubicTo(
        size.width * 0.65,
        size.height - 40,
        size.width * 0.85,
        size.height - 20,
        size.width,
        size.height - 55,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _UpwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, 40)
      ..quadraticBezierTo(
        size.width * 0.5,
        0,
        size.width,
        40,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class AnimatedArrow extends StatefulWidget {
  final Color color;
  const AnimatedArrow({super.key, required this.color});

  @override
  State<AnimatedArrow> createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: child,
        );
      },
      child: Icon(
        Icons.arrow_forward_rounded,
        color: widget.color,
        size: 24,
      ),
    );
  }
}
