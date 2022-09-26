import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twitterclone/data/model/post_model.dart';
import 'package:twitterclone/data/model/retweet_model.dart';
import 'package:twitterclone/data/model/user_model.dart';
import 'package:twitterclone/data/service/data_services.dart';
import 'package:twitterclone/utils/constants/colors.dart';

import '../../utils/constants/paths.dart';

class TweetScreen extends StatelessWidget {
  TweetScreen({Key? key}) : super(key: key);

  final TextEditingController _tweetController = TextEditingController();
  final collection = FirebaseFirestore.instance.collection('users');
  final DataServices _dataServices = DataServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 25,
                  color: Colors.black,
                )),
            const Spacer(),
            Image.asset(
              AppPaths.twitterLogo,
              height: 20,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shadowColor: Colors.black,
                primary: themeColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () async {
                final navigator = Navigator.of(context);
                final myData = await _dataServices.getMyData();

                final newPost = PostModel(
                  author: UserModel(
                    userId: myData?.userId,
                    profilePicture: "https://picsum.photos/200",
                    name: myData?.name,
                  ),
                  retweet: RetweetModel(isRetweeted: false, retweetedId: ""),
                  postContent: _tweetController.text.trim(),
                  comments: [],
                  likes: [],
                  retweets: 0,
                  dateCreated: DateTime.now(),
                );

                if (newPost.postContent!.isNotEmpty) {
                  if (await DataServices().addPost(newPost)) navigator.pop();
                }
              },
              child: const Text(
                "Tweet",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 35,
                    )),
                Expanded(
                  child: TextFormField(
                    controller: _tweetController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    autofocus: true,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "What's Happening",
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
