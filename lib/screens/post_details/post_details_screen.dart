import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/enums/date_sorting.dart';
import 'package:instagram_app/screens/components/animations/error_animation_view.dart';
import 'package:instagram_app/screens/components/animations/loading_animation_view.dart';
import 'package:instagram_app/screens/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/screens/components/comment/compact_comments_column.dart';
import 'package:instagram_app/screens/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_app/screens/components/dialogs/delete_dialog.dart';
import 'package:instagram_app/screens/components/like_button.dart';
import 'package:instagram_app/screens/components/likes_count_view.dart';
import 'package:instagram_app/screens/components/post/post_date_view.dart';
import 'package:instagram_app/screens/components/post/post_display_name_and_message_view.dart';
import 'package:instagram_app/screens/components/post/post_image_or_video_view.dart';
import 'package:instagram_app/screens/constants/strings.dart';
import 'package:instagram_app/screens/post_comments/post_comments_screen.dart';
import 'package:instagram_app/state/comments/models/post_comments_request.dart';
import 'package:instagram_app/state/posts/models/post.dart';
import 'package:instagram_app/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_app/state/posts/providers/delete_post_provider.dart';
import 'package:instagram_app/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;

  const PostDetailsView({Key? key, required this.post}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3, // at most 3 comments
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );

    // get the actual post together with its comments
    final postWithComments = ref.watch(specificPostWithCommentsProvider(request));

    // can we delete this post?
    final canDeletePost = ref.watch(canCurrentUserDeletePostProvider(widget.post));

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          // share button is always present
          postWithComments.when(
            data: (postWithComments) {
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  final url = postWithComments.post.fileUrl;
                  Share.share(url, subject: Strings.checkOutThisPost);
                },
              );
            },
            error: (error, stackTrace) => const SmallErrorAnimationView(),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          // delete button or no delete button if user cannot delete this post
          if (canDeletePost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shouldDeletePost =
                    await const DeleteDialog(titleOfObjectToDelete: Strings.post)
                        .present(context)
                        .then((shouldDelete) => shouldDelete ?? false);
                if (shouldDeletePost) {
                  await ref.read(deletePostProvider.notifier).deletePost(post: widget.post);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
                // delete the post now
              },
            )
        ],
      ),
      body: postWithComments.when(
        data: (postWithComments) {
          final postId = postWithComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(post: postWithComments.post),
                // like and comment buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // like button if post allows liking it
                    if (postWithComments.post.allowsLikes) LikeButton(postId: postId),
                    // comment button if post allows commenting on it
                    if (postWithComments.post.allowsComments)
                      IconButton(
                        icon: const Icon(Icons.mode_comment_outlined),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostCommentsScreen(postId: postId),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                // post details (shows divider at bottom)
                PostDisplayNameAndMessageView(post: postWithComments.post),
                PostDateView(dateTime: postWithComments.post.createdAt),
                const Padding(padding: EdgeInsets.all(8.0), child: Divider(color: Colors.white70)),
                // comments
                CompactCommentsColumn(comments: postWithComments.comments),
                // display like count
                if (postWithComments.post.allowsLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [LikesCountView(postId: postId)]),
                  ),
                // add spacing to bottom of screen
                const SizedBox(height: 100),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
