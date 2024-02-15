part of 'posts_bloc.dart';

// Define abstract class for all possible states
@immutable
abstract class PostsState {}

// Initial state of the PostsBloc
class PostsInitial extends PostsState {}

// Abstract class to represent states that are related to actions
abstract class PostsActionState extends PostsState {}

// State indicating that posts are being fetched/loading
class PostsFetchingLoadingState extends PostsState {}

// State indicating that posts were fetched successfully
class PostsGetSuccessfulState extends PostsState {
  final List<PostsModel> posts;
  PostsGetSuccessfulState({
    required this.posts,
  });
}

// State indicating that a new post was created successfully
class PostsCreatedSuccessfulState extends PostsState {}

// State indicating that creating a new post failed
class PostsCreatedFailedState extends PostsState {}

// State indicating that a post was edited successfully
class PostsEditedSuccessfulState extends PostsState {}

// State indicating that editing a post failed
class PostsEditedFailedState extends PostsState {}

// State indicating that a post was deleted successfully
class PostsDeletedSuccessfulState extends PostsState {}

// State indicating that deleting a post failed
class PostsDeletedFailedState extends PostsState {}
