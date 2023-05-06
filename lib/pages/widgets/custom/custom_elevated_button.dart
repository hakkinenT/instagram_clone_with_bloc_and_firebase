import 'package:flutter/material.dart';

import '../../../core/config/theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const CustomElevatedButton(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: key,
      width: double.maxFinite,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor: blueColor,
            padding: const EdgeInsets.all(8)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
