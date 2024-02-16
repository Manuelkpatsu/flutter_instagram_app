import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_app/state/constants/fire_store_field_name.dart';

@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required String fromUserId,
    required String onPostId,
    required String comment,
  }) : super({
          FireStoreFieldName.userId: fromUserId,
          FireStoreFieldName.postId: onPostId,
          FireStoreFieldName.comment: comment,
          FireStoreFieldName.createdAt: FieldValue.serverTimestamp(),
        });
}
