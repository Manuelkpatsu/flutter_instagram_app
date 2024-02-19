import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_app/screens/components/animations/error_animation_view.dart';
import 'package:instagram_app/screens/components/animations/loading_animation_view.dart';
import 'package:instagram_app/screens/components/post/posts_grid_view.dart';
import 'package:instagram_app/screens/constants/strings.dart';
import 'package:instagram_app/state/posts/providers/all_posts_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(allPostsProvider);

        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(text: Strings.noPostsAvailable);
          } else {
            return PostsGridView(posts: posts);
          }
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
