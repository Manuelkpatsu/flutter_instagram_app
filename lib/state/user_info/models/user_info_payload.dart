import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instagram_app/state/constants/fire_store_field_name.dart';
import 'package:instagram_app/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String displayName,
    required String? email,
  }) : super({
          FireStoreFieldName.userId: userId,
          FireStoreFieldName.displayName: displayName,
          FireStoreFieldName.email: email ?? '',
        });
}
