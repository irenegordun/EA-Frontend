import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        child: CircleAvatar(
            //   backgroundImage: NetworkImage(
            //       'https://icon-library.com/images/no-user-image-icon/no-user-image-icon-0.jpg'),
            ),
      ),
    );
  }
}
