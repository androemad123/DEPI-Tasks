import 'package:flutter/material.dart';
import '../../../core/models/messege_model.dart';
import '../../../core/models/user_model.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  final List<UserModel> users = const [
    UserModel(
      id: '1',
      name: 'andrew',
      profileImageUrl: 'https://i.pravatar.cc/150?img=1',
      isOnline: true,
    ),
    UserModel(
      id: '2',
      name: 'adam',
      profileImageUrl: 'https://i.pravatar.cc/150?img=2',
      isOnline: false,
    ),
    UserModel(
      id: '3',
      name: 'salem',
      profileImageUrl: 'https://i.pravatar.cc/150?img=3',
      isOnline: false,
    ),
    UserModel(
      id: '4',
      name: 'ahmed',
      profileImageUrl: 'https://i.pravatar.cc/150?img=4',
      isOnline: true,
    ),
    UserModel(
      id: '5',
      name: 'malak',
      profileImageUrl: 'https://i.pravatar.cc/150?img=5',
      isOnline: false,
    ),
    UserModel(
      id: '6',
      name: 'yasmina',
      profileImageUrl: 'https://i.pravatar.cc/150?img=6',
      isOnline: false,
    ),
  ];

  List<MessageModel> get dummyMessages => [
    MessageModel(
      id: 'm1',
      senderId: '1',
      receiverId: '0',
      text: 'Hey there!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      isSeen: false,
    ),
    MessageModel(
      id: 'm2',
      senderId: '2',
      receiverId: '0',
      text: 'What\'s up?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isSeen: true,
    ),
    MessageModel(
      id: 'm3',
      senderId: '3',
      receiverId: '0',
      text: 'Call me back.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isSeen: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.add),SizedBox(width: 10,),Icon(Icons.facebook_outlined),SizedBox(width: 15,)],
        title: const Text(
          "messenger",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700, // Bold
            color: Colors.blueAccent
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildStories(),
          Expanded(
            child: ListView.builder(
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final message = dummyMessages[index];

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(userModel: user),
                      ),
                    );
                  },
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(user.profileImageUrl ?? ''),
                      ),
                      if (user.isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        )
                    ],
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    message.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatTime(message.timestamp),
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (!message.isSeen)
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            "1",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Ask Meta AI or Search",
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Color(0xffEFEFEF),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildStories() {
    final storyUsers = users;

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: storyUsers.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[300],
                      child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset("assets/images/Andrew_Habib.png"))
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const SizedBox(
                  width: 60,
                  child: Text(
                    "Drop a thought",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          }

          final user = storyUsers[index - 1];

          return Column(
            children: [
              Stack(
                children: [
                  // Story border effect
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(user.profileImageUrl ?? ''),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  if (user.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 60,
                child: Text(
                  user.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays >= 1) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inMinutes}m ago';
    }
  }
}
