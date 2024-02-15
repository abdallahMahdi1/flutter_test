import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../models/post_models.dart';
import '../repository/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    // Define event handlers for each event
    on<PostsGetEvent>(_onPostsGetEvent);
    on<PostsCreateEvent>(_onPostsCreateEvent);
    on<PostsEditEvent>(_onPostsEditEvent);
    on<PostsDeleteEvent>(_onPostsDeleteEvent);
  }

  FutureOr<void> _onPostsGetEvent(
      PostsGetEvent event, Emitter<PostsState> emit) async {
    try {
      // Emit a loading state before fetching posts
      emit(PostsFetchingLoadingState());
      // Fetch posts from repository
      List<PostsModel> posts = await PostsRepo.fetchPosts();
      // Emit successful state with fetched posts
      emit(PostsGetSuccessfulState(posts: posts));
    } catch (e) {
      // If an error occurs during fetch, emit a failed state
      emit(PostsCreatedFailedState());
    }
  }

  FutureOr<void> _onPostsEditEvent(
      PostsEditEvent event, Emitter<PostsState> emit) async {
    // Call repository to edit post
    bool result = await PostsRepo().editPost(
      description: event.description,
      email: event.email,
      id: event.id,
      imgLink: event.imgLink,
      title: event.title,
    );
    // Check if editing was successful
    if (result == true) {
      emit(PostsEditedSuccessfulState());
    } else {
      emit(PostsEditedFailedState());
    }
  }

  FutureOr<void> _onPostsDeleteEvent(
      PostsDeleteEvent event, Emitter<PostsState> emit) async {
    // Emit a loading state before deleting post
    emit(PostsFetchingLoadingState());
    // Call repository to delete post
    bool result = await PostsRepo().deletePost(id: event.id);
    // Check if deletion was successful
    if (result == true) {
      emit(PostsDeletedSuccessfulState());
    } else {
      emit(PostsDeletedFailedState());
    }
  }

  FutureOr<void> _onPostsCreateEvent(
      PostsCreateEvent event, Emitter<PostsState> emit) async {
    // Call repository to add post
    bool result = await PostsRepo().addPost(
      description: event.description,
      email: event.email,
      id: event.description, // Check if this should be event.id
      imgLink: event.imgLink,
      title: event.title,
    );
    // Check if creation was successful
    if (result == true) {
      emit(PostsCreatedSuccessfulState());
    } else {
      emit(PostsCreatedFailedState());
    }
  }
}
