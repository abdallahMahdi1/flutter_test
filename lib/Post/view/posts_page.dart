import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/Post/view/post_add.dart'; // Assuming this is where your AddPost widget is defined

import '../bloc/posts_bloc.dart';
import '../units/custom_post_tile.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  // Create an instance of the PostsBloc
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    // Dispatch event to fetch posts when the widget is initialized
    postsBloc.add(PostsGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Page'),
        // Reload posts when the refresh icon is pressed
        leading: IconButton(
          icon: const Icon(Icons.update),
          onPressed: () => postsBloc.add(PostsGetEvent()),
        ),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        // Determine when to rebuild based on state changes
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              // Show loading indicator when fetching posts
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostsGetSuccessfulState:
              // Show list of posts when fetched successfully
              final successState = state as PostsGetSuccessfulState;
              return ListView.builder(
                itemCount: successState.posts.length,
                itemBuilder: (context, index) {
                  // Display each post using CustomPostTile widget
                  return CustomPostTile(
                    imgLink: successState.posts[index].imgLink,
                    title: successState.posts[index].title,
                    email: successState.posts[index].email,
                    id: successState.posts[index].id,
                    description: successState.posts[index].description,
                    onDeletePressed: () async {
                      // Delete the post when delete button is pressed
                      postsBloc.add(PostsDeleteEvent(
                        id: successState.posts[index].id,
                      ));
                      // Fetch posts again after successful deletion
                      postsBloc.add(PostsGetEvent());
                    },
                  );
                },
              );
            default:
              // Show default message if state is not recognized
              return const Center(
                child: Text('default'),
              );
          }
        },
      ),
      // Floating action button to add new posts
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigate to AddPost screen when FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPost()),
          );
        },
      ),
    );
  }
}
