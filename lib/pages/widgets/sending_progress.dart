import 'package:flutter/material.dart';

import '../../core/config/theme/colors.dart';

class SendingProgress extends StatelessWidget {
  const SendingProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: LinearProgressIndicator(
        color: blueColor,
      ),
    );
  }
}
