import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_app/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_app/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_app/state/image_upload/providers/image_upload_provider.dart';
import 'package:instagram_app/state/posts/providers/delete_post_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authSate = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);

  return authSate.isLoading ||
      isUploadingImage ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost;
});
