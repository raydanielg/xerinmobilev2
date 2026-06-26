import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';
import '../bloc/onboarding_cubit.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final AnimationController _svgCtrl;
  late final Animation<double> _svgAnim;
  late final AnimationController _textCtrl;
  late final Animation<Offset> _textAnim;

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
    _svgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _svgAnim = CurvedAnimation(parent: _svgCtrl, curve: Curves.elasticOut);
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _textAnim = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOutCubic));
    _playAnimations();
  }

  @override
  void dispose() {
    _svgCtrl.dispose();
    _textCtrl.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _playAnimations() {
    _svgCtrl.forward(from: 0);
    _textCtrl.forward(from: 0);
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    _playAnimations();
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
    context.go(AppConstants.homeRoute);
  }

  void _onGetStarted() {
    context.go(AppConstants.homeRoute);
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
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) =>
                      _buildTopSection(_pages[index], colorScheme),
                ),
              ),
              _buildBottomSection(colorScheme),
            ],
          ),
          if (_currentPage > 0)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 8,
              child: _buildBackButton(colorScheme),
            ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 24,
            child: _buildPageCounter(colorScheme),
          ),
          if (_currentPage < _pages.length - 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 16,
              child: TextButton(
                onPressed: _onSkip,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                    fontSize: 15,
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
    return ClipPath(
      clipper: _CurveClipper(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withValues(alpha: 0.18),
              colorScheme.primary.withValues(alpha: 0.05),
              colorScheme.surface,
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _svgAnim,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.7 + (0.3 * _svgAnim.value),
              child: Opacity(
                opacity: _svgAnim.value,
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Image.asset(
              item.image,
              fit: BoxFit.contain,
              width: 360,
              height: 320,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(ColorScheme colorScheme) {
    final isLast = _currentPage == _pages.length - 1;

    return Container(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlideTransition(
            position: _textAnim,
            child: FadeTransition(
              opacity: _textCtrl,
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
            children: List.generate(
              _pages.length,
              (index) => _buildDot(index, colorScheme),
            ),
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
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary,
                          colorScheme.primary.withValues(alpha: 0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
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

  Widget _buildBackButton(ColorScheme colorScheme) {
    return GestureDetector(
      onTap: _onBack,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: colorScheme.primary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildPageCounter(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${(_currentPage + 1).toString().padLeft(2, '0')} / ${_pages.length.toString().padLeft(2, '0')}',
        style: TextStyle(
          color: colorScheme.primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
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
