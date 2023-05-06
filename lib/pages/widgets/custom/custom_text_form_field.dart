import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFiledSubmitted;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final EdgeInsets contentPadding;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final bool outlinedBorder;
  final bool hasBorder;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.controller,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onFiledSubmitted,
    this.validator,
    this.suffixIcon,
    this.suffixIconColor,
    this.maxLines = 1,
    this.obscureText = false,
    this.outlinedBorder = false,
    this.hasBorder = true,
    this.contentPadding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = outlinedBorder
        ? OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          )
        : const UnderlineInputBorder();

    return TextFormField(
      key: key,
      initialValue: initialValue,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFiledSubmitted,
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: outlinedBorder ? true : false,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        border: hasBorder ? inputBorder : InputBorder.none,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
      ),
    );
  }
}
