import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/screens/components/rich_two_parts_text.dart';
import 'package:instagram_app/state/comments/models/comment.dart';
import 'package:instagram_app/state/user_info/providers/user_info_model_provider.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;

  const CompactCommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (userInfo) {
        return RichTwoPartsText(leftPart: userInfo.displayName, rightPart: comment.comment);
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
