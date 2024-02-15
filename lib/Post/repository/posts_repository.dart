import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_models.dart';

// API endpoint
const String postLink = 'https://emergingideas.ae/test_apis/';

class PostsRepo {
  // Fetch posts from the API
  static Future<List<PostsModel>> fetchPosts() async {
    try {
      var response = await http
          .get(Uri.parse('${postLink}read.php?email=mike.hsch@gmail.com'));
      if (response.statusCode == 200) {
        // Parse response data into list of PostsModel
        return (jsonDecode(response.body) as List)
            .map((e) => PostsModel.fromJson((e as Map).cast()))
            .toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      // TODO: Handle fetchPosts error
      throw Exception('Failed to load posts');
    }
  }

  // Add a new post
  Future<bool> addPost({
    required id,
    required title,
    required description,
    required email,
    required imgLink,
  }) async {
    try {
      var client = http.Client();
      var response = await client.post(
        Uri.parse('${postLink}create.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "title": title,
          "description": description,
          "img_link": imgLink,
          "email": email
        }),
      );

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // TODO: Handle addPost error
      return false;
    }
  }

  // Delete a post
  Future<bool> deletePost({required id}) async {
    try {
      var response = await http.get(
          Uri.parse('${postLink}delete.php?email=mike.hsch@gmail.com&id=$id'));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // TODO: Handle deletePost error
      return false;
    }
  }

  // Edit a post
  Future<bool> editPost({
    required id,
    required title,
    required description,
    required email,
    required imgLink,
  }) async {
    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse(
            '${postLink}edit.php?email=$email&id=$id&description=$description&title=$title&img_link=$imgLink'),
      );

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // TODO: Handle editPost error
      return false;
    }
  }
}
