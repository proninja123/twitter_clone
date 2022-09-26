import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitterclone/data/model/post_model.dart';
import 'package:twitterclone/data/model/retweet_model.dart';
import 'package:twitterclone/data/model/user_model.dart';
import 'package:twitterclone/data/service/data_services.dart';
import 'package:twitterclone/utils/helper/extensions.dart';
import 'package:twitterclone/utils/widgets/common_drawer.dart';
import 'package:twitterclone/utils/widgets/custom_icons.dart';
import 'package:twitterclone/utils/widgets/floating_action_button.dart';
import 'package:twitterclone/utils/widgets/heart_animation_widget.dart';
import 'package:twitterclone/utils/widgets/share_widget.dart';
import 'package:twitterclone/view/home/re_tweet_widget.dart';
import 'package:twitterclone/view/home/tweet_screen.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final DataServices _dataServices = DataServices();
  late Stream<QuerySnapshot> postStream;
  final collection = FirebaseFirestore.instance.collection('users');

  bool _needsScroll = false;

  final _db = FirebaseFirestore.instance;
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    postStream = _db
        .collection("posts")
        .orderBy("dateCreated", descending: true)
        .snapshots();

    if (_needsScroll) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => animateScrollController());
      _needsScroll = false;
    }
    super.initState();
  }

  animateScrollController() {
    _listController.animateTo(_listController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerDragStartBehavior: DragStartBehavior.down,
      drawer: CommonDrawer(),
      drawerEdgeDragWidth: 0,
      drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TweetScreen(), fullscreenDialog: true));
        },
        child: const FloatingActionButtonWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
                size: 25,
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/twitterLogo.png",
              height: 20,
            ),
            const Spacer(),
            const SizedBox(
              width: 25,
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final allPosts = snapshot.data!.docs;
            return Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                controller: _listController,
                shrinkWrap: true,
                reverse: false,
                itemCount: allPosts.length,
                itemBuilder: (context, index) {
                  _needsScroll = true;
                  final data = PostModel.fromJson(
                      allPosts[index].data() as Map<String, dynamic>);
                  if (data.retweet?.isRetweeted == true) {}
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: (data.retweet != null &&
                                data.retweet?.isRetweeted == true)
                            ? ReTweetWidget(
                                post: data,
                                currentId: allPosts[index].id,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                        radius: 20,
                                        child: ClipOval(
                                            child: Image.network(
                                          data.author?.profilePicture ?? "",
                                          height: 40,
                                        ))),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  "${data.author?.name?.capitalize()}  ",
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: data.postContent
                                                            ?.capitalize() ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black54)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 55),
                                            child: _actionsRow(
                                                data, allPosts, index),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 15),
                      const Divider()
                    ],
                  );
                },
              ),
            );
          } else if (snapshot.data?.size == 0) {
            return const Center(
              child: Text("No Data"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Row _actionsRow(PostModel data, List<QueryDocumentSnapshot<Object?>> allPosts,
      int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomIcon(icon: Icon(Icons.comment_bank_outlined)),
        CustomIcon(
          text: data.retweets.toString(),
          icon: GestureDetector(
              onTap: () async {
                String id = allPosts[index].id;
                UserModel? myData = await _dataServices.getMyData();
                int? retweets = data.retweets;
                PostModel myModel = PostModel(
                  dateCreated: DateTime.now(),
                  retweets: 0,
                  author: UserModel(
                      name: myData?.name,
                      profilePicture: myData?.profilePicture,
                      userId: myData?.userId),
                  retweet: RetweetModel(
                      retweetedId: data.author?.userId, isRetweeted: true),
                  postContent: data.postContent,
                );
                DataServices().reTweetPost(
                  myModel: myModel,
                  retweets: retweets,
                  currentPostId: id,
                );
              },
              child: Image.asset("assets/retweet.png", height: 24)),
        ),
        CustomIcon(
          text: data.likes?.length.toString(),
          icon: HeartAnimation(model: data, currentId: allPosts[index].id),
        ),
        CustomIcon(icon: ShareWidget(post: data))
      ],
    );
  }
}
