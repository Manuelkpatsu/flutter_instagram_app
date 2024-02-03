import 'package:flutter/foundation.dart';
import 'package:instagram_app/state/constants/fire_store_collection_name.dart';
import 'package:instagram_app/state/constants/fire_store_field_name.dart';
import 'package:instagram_app/state/posts/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(FireStoreCollectionName.users)
          .where(FireStoreFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // we already have this user's info
        await userInfo.docs.first.reference.update({
          FireStoreFieldName.displayName: displayName,
          FireStoreFieldName.email: email ?? '',
        });
        return true;
      }

      // we don't have this user's info from before so we create a new user
      final payload = UserInfoPayload(userId: userId, displayName: displayName, email: email);
      await FirebaseFirestore.instance.collection(FireStoreCollectionName.users).add(payload);
      return true;
    } catch (e) {
      return false;
    }
  }
}
