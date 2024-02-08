import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/constants/strings.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';

import 'widgets/facebook_button.dart';
import 'widgets/google_button.dart';
import 'widgets/login_screen_sign_up_links.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.appName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Text(
              Strings.welcomeToAppName,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const Divider(height: 80),
            Text(
              Strings.logIntoYourAccount,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),
            FacebookButton(onPressed: ref.read(authStateProvider.notifier).loginWithFacebook),
            const SizedBox(height: 20),
            GoogleButton(onPressed: ref.read(authStateProvider.notifier).loginWithGoogle),
            const Divider(height: 80),
            const LoginScreenSignUpLinks(),
          ],
        ),
      ),
    );
  }
}
