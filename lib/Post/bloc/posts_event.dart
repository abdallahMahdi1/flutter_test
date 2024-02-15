part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

// Event for fetching posts
class PostsGetEvent extends PostsEvent {}

// Event for creating a new post
class PostsCreateEvent extends PostsEvent {
  final String id; // ID of the post
  final String title; // Title of the post
  final String description; // Description of the post
  final String imgLink; // Image link of the post
  final String email; // Email associated with the post

  PostsCreateEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.email,
  });
}

// Event for editing an existing post
class PostsEditEvent extends PostsEvent {
  final int id; // ID of the post
  final String title; // New title of the post
  final String description; // New description of the post
  final String imgLink; // New image link of the post
  final String email; // New email associated with the post

  PostsEditEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.email,
  });
}

// Event for deleting a post
class PostsDeleteEvent extends PostsEvent {
  final int id; // ID of the post to delete

  PostsDeleteEvent({
    required this.id,
  });
}
