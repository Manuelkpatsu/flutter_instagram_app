import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:instagram_app/state/comments/models/comment.dart';
import 'package:instagram_app/state/comments/models/post_comments_request.dart';
import 'package:instagram_app/state/constants/fire_store_collection_name.dart';
import 'package:instagram_app/state/constants/fire_store_field_name.dart';

final postCommentsProvider =
    StreamProvider.family.autoDispose<Iterable<Comment>, RequestForPostAndComments>(
  (ref, RequestForPostAndComments request) {
    final controller = StreamController<Iterable<Comment>>();

    final sub = FirebaseFirestore.instance
        .collection(FireStoreCollectionName.comments)
        .where(FireStoreFieldName.postId, isEqualTo: request.postId)
        .snapshots()
        .listen((snapshot) {
      final documents = snapshot.docs;
      final limitedDocuments = request.limit != null ? documents.take(request.limit!) : documents;
      final comments = limitedDocuments
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map((document) => Comment(id: document.id, document.data()));

      final result = comments.applySortingFrom(request);
      controller.sink.add(result);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
