import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';
import '../widgets/auth_logo.dart';

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
                    TextFormField(
                      controller: _nameCtrl,
                      focusNode: _nameNode,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter your full name' : null,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                        prefixIcon: Icon(
                          Icons.person_outlined,
                          color: _nameNode.hasFocus
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailCtrl,
                      focusNode: _emailNode,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter your email' : null,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'example@email.com',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: _emailNode.hasFocus
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneCtrl,
                      focusNode: _phoneNode,
                      keyboardType: TextInputType.phone,
                      validator: (v) => v == null || v.isEmpty
                          ? 'Enter your phone number'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '+255 7XX XXX XXX',
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: _phoneNode.hasFocus
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passCtrl,
                      focusNode: _passNode,
                      obscureText: _obscurePass,
                      validator: (v) =>
                          v == null || v.length < 6 ? 'Min 6 characters' : null,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '••••••••',
                        prefixIcon: Icon(
                          Icons.lock_outlined,
                          color: _passNode.hasFocus
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.35),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: IconButton(
                            icon: Icon(
                              _obscurePass
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.35),
                            ),
                            onPressed: () =>
                                setState(() => _obscurePass = !_obscurePass),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPassCtrl,
                      focusNode: _confirmNode,
                      obscureText: _obscureConfirm,
                      validator: (v) =>
                          v != _passCtrl.text ? 'Passwords do not match' : null,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: '••••••••',
                        prefixIcon: Icon(
                          Icons.lock_outlined,
                          color: _confirmNode.hasFocus
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.35),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.35),
                            ),
                            onPressed: () => setState(
                                () => _obscureConfirm = !_obscureConfirm),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSellerToggle(colorScheme),
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
            activeTrackColor: colorScheme.primary,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isSeller
            ? colorScheme.primary.withValues(alpha: 0.06)
            : colorScheme.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isSeller
              ? colorScheme.primary.withValues(alpha: 0.2)
              : colorScheme.onSurface.withValues(alpha: 0.06),
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
                  : colorScheme.onSurface.withValues(alpha: 0.35),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Become a Seller',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Register your shop & start selling',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _isSeller,
            onChanged: (v) => setState(() => _isSeller = v),
            activeColor: colorScheme.primary,
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
          TextFormField(
            controller: _shopNameCtrl,
            focusNode: _shopNameNode,
            textCapitalization: TextCapitalization.words,
            validator: (v) =>
                _isSeller && (v == null || v.isEmpty)
                    ? 'Enter your shop name'
                    : null,
            decoration: InputDecoration(
              labelText: 'Shop Name',
              hintText: 'e.g. Xerin Fashion Store',
              prefixIcon: Icon(
                Icons.badge_outlined,
                color: _shopNameNode.hasFocus
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.35),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _shopCategory,
            items: _categories.map((cat) {
              return DropdownMenuItem(value: cat, child: Text(cat));
            }).toList(),
            onChanged: (v) => setState(() => _shopCategory = v ?? 'Electronics'),
            decoration: InputDecoration(
              labelText: 'Shop Category',
              prefixIcon: Icon(
                Icons.category_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.35),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shopDescCtrl,
            focusNode: _shopDescNode,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                _isSeller && (v == null || v.isEmpty)
                    ? 'Enter a short description'
                    : null,
            decoration: InputDecoration(
              labelText: 'Shop Description',
              hintText: 'Tell customers about your shop...',
              alignLabelWithHint: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Icon(
                  Icons.description_outlined,
                  color: _shopDescNode.hasFocus
                      ? colorScheme.primary
                      : colorScheme.onSurface.withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shopAddressCtrl,
            focusNode: _shopAddressNode,
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                _isSeller && (v == null || v.isEmpty)
                    ? 'Enter your shop address'
                    : null,
            decoration: InputDecoration(
              labelText: 'Shop Address',
              hintText: 'e.g. Mlimani City, Dar es Salaam',
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color: _shopAddressNode.hasFocus
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
