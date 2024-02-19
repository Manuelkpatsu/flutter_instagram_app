import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/constants/strings.dart';
import 'package:instagram_app/state/posts/providers/posts_by_search_term_provider.dart';

import 'animations/data_not_found_animation_view.dart';
import 'animations/empty_contents_with_text_animation_view.dart';
import 'animations/error_animation_view.dart';
import 'post/posts_sliver_grid_view.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;

  const SearchGridView({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(text: Strings.enterYourSearchTerm),
      );
    }

    final posts = ref.watch(postsBySearchTermProvider(searchTerm));

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(child: DataNotFoundAnimationView());
        } else {
          return PostsSliverGridView(posts: posts);
        }
      },
      error: (error, stackTrace) => const SliverToBoxAdapter(child: ErrorAnimationView()),
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
    );
  }
}
