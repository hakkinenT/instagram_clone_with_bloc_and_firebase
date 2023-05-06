import 'package:flutter/material.dart';
import 'package:school_management/pages/add_post/add_post.dart';

import '../../pages/feed/feed_page.dart';
import '../../pages/profile/profile_page.dart';

const defaultUserImage =
    'https://img.freepik.com/free-icon/user_318-563642.jpg?w=360';

const googleImage = 'assets/images/google-logo.svg';
const instagramImage = 'assets/images/ic_instagram.svg';

List<Widget> homeScreens = const [
  FeedPage(),
  Text('Search'),
  AddPost(),
  Text('Reels'),
  ProfilePage(),
];
