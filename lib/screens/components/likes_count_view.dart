import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/components/constants/strings.dart';
import 'package:instagram_app/state/likes/providers/post_likes_count_provider.dart';
import 'package:instagram_app/state/posts/typedefs/post_id.dart';

import 'animations/small_error_animation_view.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;

  const LikesCountView({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (int likesCount) {
        final personOrPeople = likesCount == 1 ? Strings.person : Strings.people;
        final likesText = '$likesCount $personOrPeople ${Strings.likedThis}';
        return Text(likesText);
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
