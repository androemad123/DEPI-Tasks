import 'package:flutter/material.dart';
class CommentScreen extends StatefulWidget {
  final int postIndex;
  final List<String> comments;
  final String postUsername;
  final String postUserImage;
  final String postUserCaption;
  const CommentScreen({
    super.key,
    required this.postIndex,
    required this.comments,
    required this.postUsername,
    required this.postUserImage,
    required this.postUserCaption,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  late List<String> _currentComments; // Use late to initialize in initState

  @override
  void initState() {
    super.initState();
    _currentComments = List.from(widget.comments); // Create a mutable copy
  }

  void _submitComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _currentComments.add("You: ${_commentController.text.trim()}"); // Add new comment
      });
      _commentController.clear(); // Clear the text field
      // Optionally, you can also pop the screen with the new comment
      // Navigator.pop(context, _commentController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: false, // Align title to left
        elevation: 0.0, // Remove shadow
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Post's original caption and user info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(widget.postUserImage),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: '${widget.postUsername} ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: widget.postUserCaption),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5),
          Expanded(
            child: ListView.builder(
              itemCount: _currentComments.length,
              itemBuilder: (context, index) {
                // Assuming comments are in "Username: Comment text" format for simplicity
                final commentParts = _currentComments[index].split(': ');
                final commentUsername = commentParts.length > 1 ? commentParts[0] : 'User';
                final commentText = commentParts.length > 1 ? commentParts.sublist(1).join(': ') : commentParts[0];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        // You might want to pass actual comment user images here
                        child: Icon(Icons.person, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: '$commentUsername ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: commentText),
                            ],
                          ),
                        ),
                      ),
                      // Optional: Add a like icon for comments
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.favorite_border, size: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://placehold.co/40x40/FF0000/FFFFFF?text=You'), // Your profile image
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment as You...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero, // Remove default padding
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _submitComment,
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          // Add a small bottom padding to account for keyboard if it pops up
          MediaQuery.of(context).viewInsets.bottom == 0
              ? const SizedBox(height: 0)
              : SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}