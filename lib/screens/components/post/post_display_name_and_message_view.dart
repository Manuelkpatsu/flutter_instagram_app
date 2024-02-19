import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/screens/components/rich_two_parts_text.dart';
import 'package:instagram_app/state/posts/models/post.dart';
import 'package:instagram_app/state/user_info/providers/user_info_model_provider.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;

  const PostDisplayNameAndMessageView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(post.userId));

    return userInfoModel.when(
      data: (userInfoModel) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichTwoPartsText(leftPart: userInfoModel.displayName, rightPart: post.message),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
