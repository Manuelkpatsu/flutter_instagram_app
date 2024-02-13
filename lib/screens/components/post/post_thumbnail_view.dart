import 'package:flutter/material.dart';
import 'package:instagram_app/state/posts/models/post.dart';

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostThumbnailView({required this.post, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.network(post.thumbnailUrl, fit: BoxFit.cover),
    );
  }
}
