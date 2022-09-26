import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twitterclone/data/model/post_model.dart';
import 'package:twitterclone/data/model/retweet_model.dart';
import 'package:twitterclone/data/model/user_model.dart';
import 'package:twitterclone/data/service/data_services.dart';
import 'package:twitterclone/utils/helper/extensions.dart';
import 'package:twitterclone/utils/widgets/custom_icons.dart';
import 'package:twitterclone/utils/widgets/heart_animation_widget.dart';
import 'package:twitterclone/utils/widgets/share_widget.dart';

class ReTweetWidget extends StatefulWidget {
  final PostModel post;
  final String currentId;

  const ReTweetWidget({Key? key, required this.post, required this.currentId})
      : super(key: key);

  @override
  State<ReTweetWidget> createState() => _ReTweetWidgetState();
}

class _ReTweetWidgetState extends State<ReTweetWidget> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> retweetRef =
      collection.doc(widget.post.retweet?.retweetedId).get();

  final collection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: retweetRef,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userData = UserModel.fromJson(
                snapshot.data?.data() as Map<String, dynamic>);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: Image.network(
                        widget.post.author?.profilePicture ?? "",
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.author?.name?.capitalize() ?? "",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text("Reetweeted"),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 15,
                                child: ClipOval(
                                    child: Image.network(
                                  userData.profilePicture ?? "",
                                  height: 30,
                                ))),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "${userData.name?.capitalize()}  ",
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: widget.post.postContent
                                                    ?.capitalize() ??
                                                '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomIcon(
                                  icon: Icon(Icons.comment_bank_outlined)),
                              CustomIcon(
                                text: widget.post.retweets.toString(),
                                icon: GestureDetector(
                                  onTap: () async {
                                    int? retweets = widget.post.retweets;

                                    UserModel? myModel =
                                        await DataServices().getMyData();

                                    PostModel postModel = PostModel(
                                        author: UserModel(
                                          userId: myModel?.userId,
                                          name: myModel?.name,
                                          email: myModel?.email,
                                          profilePicture:
                                              myModel?.profilePicture,
                                        ),
                                        retweets: 0,
                                        postContent: widget.post.postContent,
                                        dateCreated: DateTime.now(),
                                        retweet: RetweetModel(
                                            isRetweeted: true,
                                            retweetedId: widget
                                                .post.retweet?.retweetedId));

                                    DataServices().reTweetPost(
                                        myModel: postModel,
                                        retweets: retweets,
                                        currentPostId: widget.currentId);
                                  },
                                  child: Image.asset("assets/retweet.png",
                                      height: 24),
                                ),
                              ),
                              CustomIcon(
                                text: widget.post.likes?.length.toString(),
                                icon: HeartAnimation(
                                    model: widget.post,
                                    currentId: widget.currentId),
                              ),
                              CustomIcon(icon: ShareWidget(post: widget.post))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
