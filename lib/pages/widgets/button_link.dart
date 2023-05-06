import 'package:flutter/material.dart';

import '../../core/config/theme/colors.dart';

class ButtonLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onLinkTapped;

  const ButtonLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onLinkTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: onLinkTapped,
            child: Text(
              linkText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: blueColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
