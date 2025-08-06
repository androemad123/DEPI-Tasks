import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InstagramHomePage extends StatefulWidget {
  const InstagramHomePage({super.key});

  @override
  State<InstagramHomePage> createState() => _InstagramHomePageState();
}

class _InstagramHomePageState extends State<InstagramHomePage> {
  // Dummy data for stories and posts
  final List<Map<String, String>> _stories = [
    {'name': 'Andrew', 'image': 'https://i.pravatar.cc/150?img=1'},
    {'name': 'Salem', 'image': 'https://i.pravatar.cc/150?img=2'},
    {'name': 'Anas', 'image': 'https://i.pravatar.cc/150?img=3'},
    {'name': 'Samir', 'image': 'https://i.pravatar.cc/150?img=4'},
    {'name': 'Jana', 'image': 'https://i.pravatar.cc/150?img=5'},
    {'name': 'Malak', 'image': 'https://i.pravatar.cc/150?img=6'},
  ];

  final List<Map<String, String>> _posts = [
    {
      'username': 'Mina',
      'userImage': 'https://i.pravatar.cc/150?img=7',
      'postImage': 'https://i.pravatar.cc/150?img=8',
      'caption': 'Me as a teenager ',
      'likes': '1,234',
    },
    {
      'username': 'Anas',
      'userImage': 'https://i.pravatar.cc/150?img=3',
      'postImage': 'https://i.pravatar.cc/150?img=11',
      'caption': 'looking for a wife',
      'likes': '876',
    },
    {
      'username': 'Samir',
      'userImage': 'https://i.pravatar.cc/150?img=4',
      'postImage': 'https://i.pravatar.cc/150?img=12',
      'caption': '#having fun',
      'likes': '2,500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 30), // A custom font like Billabong would be ideal here
        ),
        surfaceTintColor: Colors.white,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // Handle add post
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Handle likes
            },
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined),
            onPressed: () {
              // Handle messages
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stories Section
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(_stories[index]['image']!),
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _stories[index]['name']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 0.5),

          // Posts Feed
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return _buildPostCard(_posts[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, String> post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(post['userImage']!),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 8),
              Text(
                post['username']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.more_vert),
            ],
          ),
        ),
        Image.network(
          post['postImage']!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              height: 300,
              child: const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '${post['likes']!} likes',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '${post['username']!} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: post['caption']!),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            'View all comments',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            '1 hour ago',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}