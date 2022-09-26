import 'package:flutter/material.dart';
import 'package:twitterclone/data/model/post_model.dart';
import 'package:twitterclone/data/service/data_services.dart';
import 'package:twitterclone/utils/helper/shared_preferences_helper.dart';

class HeartAnimation extends StatefulWidget {
  final PostModel model;
  final String currentId;

  const HeartAnimation({Key? key, required this.model, required this.currentId})
      : super(key: key);

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with TickerProviderStateMixin {
  final DataServices _dataServices = DataServices();

  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isLikedClickedValue = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        value: 0,
        vsync: this,
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 100));

    _animation = Tween<double>(begin: 25, end: 30).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _animationController
            .forward()
            .then((value) => _animationController.reverse());
        await _dataServices.addLikes(
            likes: widget.model.likes ?? [], currentId: widget.currentId);
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final hasALike = widget.model.likes != null &&
              widget.model.likes!
                  .contains(SharedPreferenceHelper().getUserModel()!.userId);
          return Icon(
            hasALike ? Icons.favorite : Icons.favorite_outline,
            color: hasALike ? Colors.red : null,
            size: _animation.value,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
