import 'package:flutter/foundation.dart';

@immutable
class FireStoreCollectionName {
  static const users = 'users';
  static const posts = 'posts';
  static const comments = 'comments';
  static const likes = 'likes';
  static const thumbnails = 'thumbnails';

  const FireStoreCollectionName._();
}
