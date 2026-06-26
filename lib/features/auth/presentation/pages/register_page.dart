import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
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

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  final _nameNode = FocusNode();
  final _emailNode = FocusNode();
  final _phoneNode = FocusNode();
  final _passNode = FocusNode();
  final _confirmNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _agree = false;
  bool _isSeller = false;

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
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    _nameNode.dispose();
    _emailNode.dispose();
    _phoneNode.dispose();
    _passNode.dispose();
    _confirmNode.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate() && _agree) {
      if (_isSeller) {
        context.go(AppConstants.sellerDetailsRoute);
      } else {
        context.go(AppConstants.verifyOtpRoute);
      }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        const SizedBox(width: 12),
                        Expanded(child: _buildSellerToggle(colorScheme)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const AuthLogo(width: 180, height: 110),
                    const SizedBox(height: 20),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isSeller
                          ? 'Register your shop and start selling'
                          : 'Join us and start shopping today',
                      style: TextStyle(
                        fontSize: 15,
                        color: colorScheme.onSurface.withValues(alpha: 0.45),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AuthTextField(
                      controller: _nameCtrl,
                      focusNode: _nameNode,
                      label: 'Full Name',
                      hint: 'John Doe',
                      icon: Icons.person_outlined,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter your full name' : null,
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _emailCtrl,
                      focusNode: _emailNode,
                      label: 'Email',
                      hint: 'example@email.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter your email' : null,
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _phoneCtrl,
                      focusNode: _phoneNode,
                      label: 'Phone Number',
                      hint: '7XXXXXXXX',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Enter your phone number';
                        }
                        if (v.length != 9) {
                          return 'Phone number must be 9 digits';
                        }
                        if (!RegExp(r'^[67]\d{8}$').hasMatch(v)) {
                          return 'Enter a valid Tanzania number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _passCtrl,
                      focusNode: _passNode,
                      label: 'Password',
                      hint: 'Enter your password',
                      icon: Icons.lock_outlined,
                      obscureText: _obscurePass,
                      validator: (v) =>
                          v == null || v.length < 6 ? 'Min 6 characters' : null,
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePass
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePass = !_obscurePass),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _confirmPassCtrl,
                      focusNode: _confirmNode,
                      label: 'Confirm Password',
                      hint: 'Re-enter your password',
                      icon: Icons.lock_outlined,
                      obscureText: _obscureConfirm,
                      validator: (v) =>
                          v != _passCtrl.text ? 'Passwords do not match' : null,
                      suffix: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 22,
                          width: 22,
                          child: Checkbox(
                            value: _agree,
                            onChanged: (v) =>
                                setState(() => _agree = v ?? false),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            activeColor: colorScheme.primary,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                fontSize: 13,
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const TextSpan(text: ' & '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: AnimatedOpacity(
                        opacity: _agree ? 1.0 : 0.5,
                        duration: const Duration(milliseconds: 200),
                        child: ElevatedButton(
                          onPressed: _onRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _isSeller ? 'Next' : 'Create Account',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.go(AppConstants.signInRoute),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSellerToggle(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Become a Seller',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: _isSeller ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Start selling your products',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        Switch.adaptive(
          value: _isSeller,
          onChanged: (v) => setState(() => _isSeller = v),
          activeTrackColor: colorScheme.primary,
          activeColor: colorScheme.onPrimary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

}
