import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:twitterclone/data/model/post_model.dart';

class ShareWidget extends StatelessWidget {
  const ShareWidget({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Post',
      text: post.postContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: share,
      child: const Icon(
        Icons.share_outlined,
        size: 20,
      ),
    );
  }
}
