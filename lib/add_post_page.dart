import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {
  final Map<String, String>? post;
  final String username;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  AddPostPage({this.post, required this.username})
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
    return Scaffold(
      appBar: AppBar(
        title: Text(post == null ? 'Add New Post' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitPost(context),
              child: Text(post == null ? 'Submit' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
