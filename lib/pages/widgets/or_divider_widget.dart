import 'package:flutter/material.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        SizedBox(
          width: 20,
        ),
        Text(
          'OR',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(child: Divider())
      ],
    );
  }
}
