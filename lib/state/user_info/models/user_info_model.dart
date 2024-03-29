import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_app/state/constants/fire_store_field_name.dart';
import 'package:instagram_app/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String? email;

  UserInfoModel({required this.userId, required this.displayName, required this.email})
      : super({
          FireStoreFieldName.userId: userId,
          FireStoreFieldName.displayName: displayName,
          FireStoreFieldName.email: email,
        });

  UserInfoModel.fromJson(Map<String, dynamic> json, {required UserId userId})
      : this(
          userId: userId,
          displayName: json[FireStoreFieldName.displayName] ?? '',
          email: json[FireStoreFieldName.email],
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email;

  @override
  int get hashCode => Object.hashAll([userId, displayName, email]);
}
