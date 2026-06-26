import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _Country {
  final String name;
  final String flag;
  final String dialCode;
  final String regex;

  const _Country({
    required this.name,
    required this.flag,
    required this.dialCode,
    required this.regex,
  });
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  final _phoneCtrl = TextEditingController();
  final _phoneNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
  static const List<_Country> _countries = [
    _Country(
        name: 'Tanzania',
        flag: '🇹🇿',
        dialCode: '+255',
        regex: r'^[67]\d{8}$'),
    _Country(
        name: 'Kenya', flag: '🇰🇪', dialCode: '+254', regex: r'^[71]\d{8}$'),
    _Country(
        name: 'Uganda', flag: '🇺🇬', dialCode: '+256', regex: r'^[7]\d{8}$'),
  ];
  _Country _selectedCountry = _countries[0];

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
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _phoneNode.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(AppConstants.signInRoute);
                        }
                      },
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
                    const Center(
                      child: AuthLogo(width: 180, height: 110),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Enter your phone number and we will send you a verification code to reset your password.',
                      style: TextStyle(
                        fontSize: 15,
                        color: colorScheme.onSurface.withValues(alpha: 0.45),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (!_isSubmitted)
                      AuthTextField(
                        controller: _phoneCtrl,
                        focusNode: _phoneNode,
                        label: 'Phone Number',
                        hint: '7XXXXXXXX',
                        keyboardType: TextInputType.phone,
                        maxLength: 9,
                        prefix: Container(
                          margin: const EdgeInsets.only(left: 4, right: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 6),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: PopupMenuButton<_Country>(
                            initialValue: _selectedCountry,
                            onSelected: (country) =>
                                setState(() => _selectedCountry = country),
                            itemBuilder: (context) {
                              return _countries.map((country) {
                                return PopupMenuItem<_Country>(
                                  value: country,
                                  child: Row(
                                    children: [
                                      Text(
                                        country.flag,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        country.dialCode,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        country.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: colorScheme.onSurface
                                              .withValues(alpha: 0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _selectedCountry.flag,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _selectedCountry.dialCode,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 16,
                                  color: colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 120,
                          minHeight: 40,
                          maxWidth: 120,
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 130,
                          right: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Enter your phone number';
                          }
                          if (v.length != 9) {
                            return 'Phone number must be 9 digits';
                          }
                          if (!RegExp(_selectedCountry.regex).hasMatch(v)) {
                            return 'Enter a valid ${_selectedCountry.name} number';
                          }
                          return null;
                        },
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: colorScheme.primary,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Code sent!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Check your SMS for the verification code to reset your password.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.55),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 32),
                    if (!_isSubmitted)
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _onSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Send Verification Code',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () => context.go(AppConstants.signInRoute),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(
                              color: colorScheme.onSurface.withValues(alpha: 0.12),
                            ),
                          ),
                          child: Text(
                            'Back to Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
