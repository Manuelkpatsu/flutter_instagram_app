import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/screens/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/screens/components/constants/strings.dart';
import 'package:instagram_app/screens/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_app/screens/components/dialogs/delete_dialog.dart';
import 'package:instagram_app/state/auth/providers/user_id_provider.dart';
import 'package:instagram_app/state/comments/models/comment.dart';
import 'package:instagram_app/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_app/state/user_info/providers/user_info_model_provider.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;

  const CommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (userInfo) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final shouldDeleteComment = await displayDeleteDialog(context);
                    if (shouldDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                )
              : null,
          title: Text(userInfo.displayName),
          subtitle: Text(comment.comment),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then((value) => value ?? false);
}
