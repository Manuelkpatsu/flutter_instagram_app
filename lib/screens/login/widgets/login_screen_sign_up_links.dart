import 'package:flutter/material.dart';
import 'package:instagram_app/screens/components/rich_text/base_text.dart';
import 'package:instagram_app/screens/components/rich_text/rich_text_widget.dart';
import 'package:instagram_app/screens/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreenSignUpLinks extends StatelessWidget {
  const LoginScreenSignUpLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1),
      texts: [
        BaseText.plain(text: Strings.dontHaveAnAccount),
        BaseText.plain(text: Strings.signUpOn),
        BaseText.link(
          text: Strings.facebook,
          onTap: () => launchUrl(Uri.parse(Strings.facebookSignupUrl)),
        ),
        BaseText.plain(text: Strings.orCreateAnAccountOn),
        BaseText.link(
          text: Strings.google,
          onTap: () => launchUrl(Uri.parse(Strings.googleSignupUrl)),
        ),
      ],
    );
  }
}
