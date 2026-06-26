import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _otpCtls =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  late final AnimationController _animCtrl;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (final c in _otpCtls) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _animCtrl.dispose();
    super.dispose();
  }

  void _onOtpChange(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _onOtpKey(int index, String value) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onVerify() {
    final otp = _otpCtls.map((c) => c.text).join();
    if (otp.length == 4) {
      context.go(AppConstants.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary,
                          colorScheme.primary.withValues(alpha: 0.6),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.sms_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Verify OTP',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter the 4-digit code sent to your phone',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: colorScheme.onSurface.withValues(alpha: 0.45),
                      height: 1.4,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 44),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      final isFocused = _focusNodes[index].hasFocus;
                      final hasValue = _otpCtls[index].text.isNotEmpty;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 68,
                          height: 76,
                          decoration: BoxDecoration(
                            color: hasValue
                                ? colorScheme.primary.withValues(alpha: 0.08)
                                : colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isFocused
                                  ? colorScheme.primary
                                  : hasValue
                                      ? colorScheme.primary
                                          .withValues(alpha: 0.3)
                                      : colorScheme.onSurface
                                          .withValues(alpha: 0.1),
                              width: isFocused ? 2 : 1.5,
                            ),
                            boxShadow: isFocused
                                ? [
                                    BoxShadow(
                                      color: colorScheme.primary
                                          .withValues(alpha: 0.12),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: TextFormField(
                            controller: _otpCtls[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: hasValue
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                              letterSpacing: 0,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            onChanged: (v) => _onOtpChange(index, v),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _onVerify,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Verify & Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive code? ",
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '00:30',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary.withValues(alpha: 0.8),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
