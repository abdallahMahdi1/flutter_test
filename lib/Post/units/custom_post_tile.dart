import 'package:flutter/material.dart';

class CustomPostTile extends StatelessWidget {
  final String imgLink;
  final String title;
  final String email;
  final int id;
  final String description;
  final VoidCallback onDeletePressed;

  const CustomPostTile({
    super.key,
    required this.imgLink,
    required this.title,
    required this.email,
    required this.id,
    required this.description,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Navigate to edit post screen when tapped
      onTap: () {
        Navigator.pushNamed(
          context,
          '/editPost',
          arguments: {
            "id": id,
            "email": email,
            "title": title,
            "imageLink": imgLink,
            "description": description,
          },
        );
      },
      child: ListTile(
        // Display post image
        leading: Image.network(imgLink),
        // Display post title
        title: Text(title),
        // Display post email
        subtitle: Text(email),
        // Delete button to delete the post
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDeletePressed,
        ),
      ),
    );
  }
}
