import 'package:flutter/material.dart';

import 'widgets/explorer_grid_view.dart';
import 'widgets/search_user_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SearchUserBar(),
          Expanded(
            child: ExplorerGridView(),
          )
        ],
      ),
    );
  }
}
