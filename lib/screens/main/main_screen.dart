import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_app/screens/components/dialogs/logout_dialog.dart';
import 'package:instagram_app/screens/constants/strings.dart';
import 'package:instagram_app/screens/create_new_post/create_new_post_screen.dart';
import 'package:instagram_app/screens/tabs/search/search_screen.dart';
import 'package:instagram_app/screens/tabs/user_posts/user_posts_screen.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_app/state/image_upload/helpers/image_picker_helper.dart';
import 'package:instagram_app/state/image_upload/models/file_type.dart';
import 'package:instagram_app/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_app/state/providers/tab_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final List<Widget> _screens = const [UserPostsScreen(), SearchScreen(), UserPostsScreen()];
  final List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final initialIndex = ref.watch(tabProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.film),
            onPressed: () async {
              // pick a video first
              final videoFile = await ImagePickerHelper.pickVideoFromGallery();
              if (videoFile == null) {
                return;
              }

              // reset the postSettingProvider
              ref.invalidate(postSettingsProvider);

              // go to the screen to create a new post
              if (!mounted) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateNewPostScreen(
                    fileType: FileType.video,
                    fileToPost: videoFile,
                  ),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () async {
              // pick an image first
              final imageFile = await ImagePickerHelper.pickImageFromGallery();
              if (imageFile == null) {
                return;
              }

              // reset the postSettingsProvider
              ref.invalidate(postSettingsProvider);

              // go to the screen to create a new post
              if (!mounted) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateNewPostScreen(
                    fileType: FileType.image,
                    fileToPost: imageFile,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add_photo_alternate_outlined),
          ),
          IconButton(
            onPressed: () async {
              final shouldLogOut =
                  await const LogoutDialog().present(context).then((value) => value ?? false);
              if (shouldLogOut) {
                await ref.read(authStateProvider.notifier).logOut();
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(index: initialIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        currentIndex: initialIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => ref.read(tabProvider.notifier).updateTab(index),
      ),
    );
  }
}
