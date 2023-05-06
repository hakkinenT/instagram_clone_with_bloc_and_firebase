import 'package:flutter/material.dart';

class UserInformation extends StatelessWidget {
  const UserInformation(
      {super.key, required this.text, required this.topSpacing});

  final String text;
  final double topSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: topSpacing),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
