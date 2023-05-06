import 'package:flutter/material.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({
    super.key,
    this.backgroundImage,
  });

  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: backgroundImage,
    );
  }
}
