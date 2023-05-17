import 'package:flutter/material.dart';

import '../../pages/add_post/add_post.dart';
import '../../pages/feed/feed_page.dart';
import '../../pages/profile/profile_page.dart';
import '../../pages/search/search_page.dart';

const defaultUserImage =
    'https://img.freepik.com/free-icon/user_318-563642.jpg?w=360';

const googleImage = 'assets/images/google-logo.svg';
const instagramImage = 'assets/images/ic_instagram.svg';

List<Widget> homeScreens = const [
  FeedPage(),
  SearchPage(),
  AddPost(),
  Text('Reels'),
  ProfilePage(),
];

List<String> images = const [
  'https://images.unsplash.com/photo-1684230415060-c59210cd5666?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=385&q=80',
  'https://images.unsplash.com/photo-1683009427540-c5bd6a32abf6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1683166218148-9a4b499955f8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
  'https://images.unsplash.com/photo-1684177790083-588f48f38c5e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1684180114254-73c0215cd8b5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
];
