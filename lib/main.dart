import 'package:flutter/material.dart';

import 'Post/view/post_add.dart';
import 'Post/view/post_edit.dart';
import 'Post/view/posts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Initial route when the app starts
      routes: {
        // Define named routes and their corresponding widget
        '/': (context) => const PostsPage(), // Home page
        '/editPost': (context) => const PostEdit(), // Page for editing a post
        '/addPost': (context) => const AddPost(), // Page for adding a new post
      },
    );
  }
}
