import 'package:flutter/material.dart';

import '../../../core/config/theme/colors.dart';

class PickerPhotoButton extends StatelessWidget {
  const PickerPhotoButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        'Editar foto',
        style: TextStyle(
          color: blueColor,
        ),
      ),
    );
  }
}
