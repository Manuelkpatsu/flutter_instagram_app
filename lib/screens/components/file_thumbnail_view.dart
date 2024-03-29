import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_app/state/image_upload/providers/thumbnail_provider.dart';

import 'animations/loading_animation_view.dart';
import 'animations/small_error_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;

  const FileThumbnailView({required this.thumbnailRequest, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));

    return thumbnail.when(
      data: (imageWithAspectRatio) {
        return AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        );
      },
      loading: () => const LoadingAnimationView(),
      error: (error, stackTrace) => const SmallErrorAnimationView(),
    );
  }
}
