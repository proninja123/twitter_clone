import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twitterclone/data/model/post_model.dart';
import 'package:twitterclone/data/model/user_model.dart';
import 'package:twitterclone/utils/helper/shared_preferences_helper.dart';

final _db = FirebaseFirestore.instance.collection("posts");
final SharedPreferenceHelper _preferenceHelper = SharedPreferenceHelper();

class DataServices {
  Future<bool> addPost(PostModel model) async {
    try {
      await _db.add(model.toJson());
      return true;
    } on Exception catch (e) {
      debugPrint("Error while adding post: $e");
      return false;
    }
  }

  Future<void> reTweetPost(
      {required PostModel myModel,
      int? retweets,
      required String currentPostId}) async {
    try {
      await _db.add(myModel.toJson()).then((value) {
        _db.doc(currentPostId).update({"retweets": retweets! + 1});
      });
    } catch (e) {
      debugPrint("Error while retweeting post: $e");
    }
  }

  Future<UserModel?> getMyData() async {
    try {
      var collection = FirebaseFirestore.instance.collection('users');
      final data =
          await collection.doc(_preferenceHelper.getUserModel()?.userId).get();
      return UserModel.fromJson(data.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint("Error while fetching data from users collection: $e");
      return null;
    }
  }

  Future<bool> addLikes(
      {required List<String> likes, required String currentId}) async {
    try {
      if (likes.contains(_preferenceHelper.getUserModel()?.userId)) {
        //in this if we use update then it will delete all the values.
        await _db.doc(currentId).update({
          'likes':
              FieldValue.arrayRemove([_preferenceHelper.getUserModel()?.userId])
        });
        return false;
      } else {
        await _db.doc(currentId).update({
          "likes": [_preferenceHelper.getUserModel()!.userId!]
        });
        return true;
      }
    } on Exception catch (e) {
      debugPrint("Error while adding likes: $e");
      return false;
    }
  }
}
