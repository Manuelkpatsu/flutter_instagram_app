import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_app/screens/constants/app_colors.dart';
import 'package:instagram_app/screens/constants/strings.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.infinity, 44),
        elevation: 0,
        backgroundColor: AppColors.loginButtonColor,
        foregroundColor: AppColors.loginButtonTextColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.google, color: AppColors.googleColor),
          const SizedBox(width: 10),
          const Text(Strings.google),
        ],
      ),
    );
  }
}
