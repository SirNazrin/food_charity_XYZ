import 'package:flutter/material.dart';
import 'add_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> posts = [];

  void _navigateToAddPostPage({Map<String, String>? post, int? index}) async {
    final updatedPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPostPage(post: post),
      ),
    );

    if (updatedPost != null) {
      setState(() {
        if (index != null) {
          posts[index] = updatedPost; // Update existing post
        } else {
          posts.add(updatedPost); // Add new post
        }
      });
    }
  }

  void _deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Sharing Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(posts[index]['title'] ?? ''),
              subtitle: Text(posts[index]['description'] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _navigateToAddPostPage(post: posts[index], index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePost(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPostPage(),
        tooltip: 'Add Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}
