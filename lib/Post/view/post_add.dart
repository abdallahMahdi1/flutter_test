import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key); // Corrected super.key

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  Widget build(BuildContext context) {
    // Initialize TextEditingController for each input field
    final TextEditingController idController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController imageLinkController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'ID',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'description',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: imageLinkController,
              decoration: const InputDecoration(
                labelText: 'imageLink',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Dispatch PostsCreateEvent when Submit button is pressed
                postsBloc.add(PostsCreateEvent(
                  email: emailController.text,
                  title: titleController.text,
                  description: descriptionController.text,
                  id: idController.text,
                  imgLink: imageLinkController.text,
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
                  case PostsCreatedFailedState:
                    return const Center(
                      child: Center(child: Text("Failed")),
                    );
                  case PostsCreatedSuccessfulState:
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
