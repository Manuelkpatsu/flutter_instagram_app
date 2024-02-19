import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_app/state/constants/fire_store_field_name.dart';
import 'package:instagram_app/state/posts/typedefs/post_id.dart';
import 'package:instagram_app/state/posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({required PostId postId, required UserId likedBy, required DateTime date})
      : super({
          FireStoreFieldName.postId: postId,
          FireStoreFieldName.userId: likedBy,
          FireStoreFieldName.date: date.toIso8601String(),
        });
}
