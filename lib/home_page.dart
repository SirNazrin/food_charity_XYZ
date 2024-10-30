import 'package:flutter/material.dart';
import 'add_post_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> posts = [];

  void _navigateToAddPostPage({Map<String, String>? post, int? index}) async {
  final updatedPost = await showDialog<Map<String, String>>(
    context: context,
    builder: (context) => AddPostPage(
      post: post,
      username: widget.username,
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

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Sharing Posts'),
        backgroundColor: Colors.teal, // AppBar color
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16), // Space between cards
            itemBuilder: (context, index) {
              final post = posts[index];
              final isPostOwner = post['username'] == widget.username;

              return Card(
                elevation: 8, // Slightly higher shadow for card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // More rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        post['description'] ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "By: ${post['username']}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (isPostOwner)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _navigateToAddPostPage(post: post, index: index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deletePost(index),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPostPage(),
        tooltip: 'Add Post',
        backgroundColor: Colors.teal, // FAB color
        child: const Icon(Icons.add),
      ),
    );
  }
}
