import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';

class PostEdit extends StatefulWidget {
  const PostEdit({Key? key}) : super(key: key); // Corrected super.key

  @override
  State<PostEdit> createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  Map? data = {}; // Initialize data as Map

  @override
  Widget build(BuildContext context) {
    final PostsBloc postsBloc = PostsBloc();

    // Extract data from route arguments
    data = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;
    int id = data!["id"];
    String email = data!["email"];
    String title = data!["title"];
    String imageLink = data!["imageLink"];
    String description = data!["description"];

    // Initialize TextEditingController for each input field
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController imageLinkController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("edit post")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("post id is : $id"),
            const SizedBox(height: 20.0),
            Text(title),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 20.0),
            Text(description),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'description',
              ),
            ),
            const SizedBox(height: 20.0),
            Text(email),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            Text(imageLink),
            TextField(
              controller: imageLinkController,
              decoration: const InputDecoration(
                labelText: 'imageLink',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Dispatch PostsEditEvent when Submit button is pressed
                postsBloc.add(PostsEditEvent(
                  email: emailController.text.isEmpty
                      ? email
                      : emailController.text,
                  title: titleController.text.isEmpty
                      ? title
                      : titleController.text,
                  description: descriptionController.text.isEmpty
                      ? description
                      : descriptionController.text,
                  id: id,
                  imgLink: imageLinkController.text.isEmpty
                      ? imageLink
                      : imageLinkController.text,
                ));
              },
              child: const Text('Submit'),
            ),
            BlocConsumer<PostsBloc, PostsState>(
              bloc: postsBloc,
              listenWhen: (previous, current) => current is PostsActionState,
              buildWhen: (previous, current) => current is! PostsActionState,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case PostsEditedFailedState:
                    return const Center(
                      child: Center(child: Text("Failed")),
                    );
                  case PostsEditedSuccessfulState:
                    return const Center(child: Text("sucesse"));
                  default:
                    return const Center(
                      child: Center(child: Text('default')),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
