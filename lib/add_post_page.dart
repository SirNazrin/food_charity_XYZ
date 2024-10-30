import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {
  final Map<String, String>? post;
  final String username;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  AddPostPage({super.key, this.post, required this.username})
      : _titleController = TextEditingController(text: post?['title']),
        _descriptionController =
            TextEditingController(text: post?['description']);

  void _submitPost(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      Navigator.pop(context, {
        'title': title,
        'description': description,
        'username': username, // Attach username to the post
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(post == null ? 'Add New Post' : 'Edit Post'),
      content: SizedBox(
        height: 200, // Adjust the height as necessary
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without saving
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _submitPost(context),
          child: Text(post == null ? 'Submit' : 'Save Changes'),
        ),
      ],
    );
  }
}
