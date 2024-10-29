import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final Map<String, String>? post;

  AddPostPage({super.key, this.post})
      : _titleController = TextEditingController(text: post?['title']),
        _descriptionController = TextEditingController(text: post?['description']);

  void _submitPost(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      Navigator.pop(context, {'title': title, 'description': description});
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
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
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

