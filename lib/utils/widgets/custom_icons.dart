import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Widget icon;
  final String? text;

  const CustomIcon({Key? key, required this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        if(text != null) ...[
          const SizedBox(width: 5),
          Text(text!)
        ],
      ],
    );
  }
}
