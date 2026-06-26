import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthLogo extends StatelessWidget {
  final double width;
  final double height;

  const AuthLogo({
    super.key,
    this.width = 180,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SvgPicture.asset(
      'assets/logo/full_named_logo.svg',
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter: isDark
          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          : null,
    );
  }
}
