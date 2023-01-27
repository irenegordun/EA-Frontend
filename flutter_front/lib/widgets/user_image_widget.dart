import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        child: CircleAvatar(
          backgroundImage: ExactAssetImage('avatar.png'),
          radius: 200.0,
        ),
      ),
    );
  }
}
