import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_firebase/screens/add_post_screen.dart';
import 'package:insta_clone_firebase/screens/feed_screen.dart';
import 'package:insta_clone_firebase/screens/profile_screen.dart';
import 'package:insta_clone_firebase/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('likes'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
