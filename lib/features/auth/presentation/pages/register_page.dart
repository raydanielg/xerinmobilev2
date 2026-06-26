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

  final _shopNameCtrl = TextEditingController();
  final _shopDescCtrl = TextEditingController();
  final _shopAddressCtrl = TextEditingController();
  final _shopNameNode = FocusNode();
  final _shopDescNode = FocusNode();
  final _shopAddressNode = FocusNode();
  String _shopCategory = 'Electronics';

  final List<String> _categories = [
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Food & Beverages',
    'Health & Beauty',
    'Sports',
    'Books & Media',
    'Other',
  ];

  late final AnimationController _animCtrl;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _sellerFieldsAnim;

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
    _sellerFieldsAnim = CurvedAnimation(
      parent: _animCtrl,
      curve: Curves.easeOutCubic,
    );
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
    _shopNameCtrl.dispose();
    _shopDescCtrl.dispose();
    _shopAddressCtrl.dispose();
    _shopNameNode.dispose();
    _shopDescNode.dispose();
    _shopAddressNode.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate() && _agree) {
      if (_isSeller) {
        context.go(AppConstants.sellerOnboardingRoute);
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        _buildSellerToggle(colorScheme),
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
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _sellerFieldsAnim,
                      builder: (context, _) {
                        return AnimatedCrossFade(
                          duration: const Duration(milliseconds: 400),
                          crossFadeState: _isSeller
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: _buildSellerFields(colorScheme),
                          secondChild: const SizedBox.shrink(),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
                            _isSeller
                                ? 'Register as Seller'
                                : 'Create Account',
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _isSeller
            ? colorScheme.primary.withValues(alpha: 0.08)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isSeller
              ? colorScheme.primary.withValues(alpha: 0.35)
              : colorScheme.onSurface.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _isSeller
                  ? colorScheme.primary.withValues(alpha: 0.12)
                  : colorScheme.onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.store_rounded,
              color: _isSeller
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.4),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Become Seller',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _isSeller ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
          ),
          Switch.adaptive(
            value: _isSeller,
            onChanged: (v) => setState(() => _isSeller = v),
            activeTrackColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSellerFields(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.storefront_rounded,
                    size: 16, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Shop Details',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AuthTextField(
            controller: _shopNameCtrl,
            focusNode: _shopNameNode,
            label: 'Shop Name',
            hint: 'e.g. Xerin Fashion Store',
            icon: Icons.badge_outlined,
            textCapitalization: TextCapitalization.words,
            validator: (v) =>
                _isSeller && (v == null || v.isEmpty)
                    ? 'Enter your shop name'
                    : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _shopCategory,
            items: _categories.map((cat) {
              return DropdownMenuItem(value: cat, child: Text(cat));
            }).toList(),
            onChanged: (v) => setState(() => _shopCategory = v ?? 'Electronics'),
            decoration: InputDecoration(
              labelText: 'Shop Category',
              filled: true,
              fillColor: colorScheme.surface.withValues(alpha: 0.6),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon: Icon(
                Icons.category_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AuthTextField(
            controller: _shopDescCtrl,
            focusNode: _shopDescNode,
            label: 'Shop Description',
            hint: 'Tell customers about your shop...',
            icon: Icons.description_outlined,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                _isSeller && (v == null || v.isEmpty)
                    ? 'Enter a short description'
                    : null,
          ),
          const SizedBox(height: 16),
          AuthTextField(
            controller: _shopAddressCtrl,
            focusNode: _shopAddressNode,
            label: 'Shop Address',
            hint: 'e.g. Mlimani City, Dar es Salaam',
            icon: Icons.location_on_outlined,
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                _isSeller && (v == null || v.isEmpty)
                    ? 'Enter your shop address'
                    : null,
          ),
        ],
      ),
    );
  }
}
