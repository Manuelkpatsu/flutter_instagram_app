import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
      body: TextButton(
        onPressed: () async {
          await ref.read(authStateProvider.notifier).logOut();
        },
        child: const Text('Logout'),
      ),
    );
  }
}
