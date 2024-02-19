import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/constants/fire_store_collection_name.dart';
import 'package:instagram_app/state/constants/fire_store_field_name.dart';
import 'package:instagram_app/state/posts/models/post.dart';

final allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(FireStoreCollectionName.posts)
      .orderBy(FireStoreFieldName.createdAt, descending: true)
      .snapshots()
      .listen(
    (snapshots) {
      final posts = snapshots.docs.map((doc) => Post(json: doc.data(), postId: doc.id));
      controller.sink.add(posts);
    },
  );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
