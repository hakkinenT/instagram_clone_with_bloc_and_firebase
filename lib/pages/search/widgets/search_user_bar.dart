import 'package:flutter/material.dart';

class SearchUserBar extends StatelessWidget {
  const SearchUserBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Search'),
    );
  }
}
