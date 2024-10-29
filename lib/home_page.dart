import 'package:flutter/material.dart';
import 'add_post_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> posts = [];

  void _navigateToAddPostPage({Map<String, String>? post, int? index}) async {
    final updatedPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPostPage(
          post: post,
          username: widget.username,
        ),
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
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Sharing Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final isPostOwner = post['username'] == widget.username;

          return Card(
            child: ListTile(
              title: Text(post['title'] ?? ''),
              subtitle: Text("${post['description']} \nBy: ${post['username']}"),
              trailing: isPostOwner
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _navigateToAddPostPage(post: post, index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deletePost(index),
                        ),
                      ],
                    )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPostPage(),
        tooltip: 'Add Post',
        child: Icon(Icons.add),
      ),
    );
  }
}
