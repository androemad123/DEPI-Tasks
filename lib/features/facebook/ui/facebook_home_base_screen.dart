import 'package:depi_task/features/facebook/ui/chat_list_screen.dart';
import 'package:depi_task/features/facebook/ui/userProfile/facebook_user_profile_screen.dart';
import 'package:flutter/material.dart';

class FacebookHomeBaseScreen extends StatefulWidget {
  const FacebookHomeBaseScreen({super.key});

  @override
  State<FacebookHomeBaseScreen> createState() => _FacebookHomeBaseScreenState();
}

class _FacebookHomeBaseScreenState extends State<FacebookHomeBaseScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text("Home Screen")),
    ChatListScreen(),
    Center(child: Text("Settings Screen")),
    Center(child: Text("Stories Screen")),
    FacebookUserProfileScreen(),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false, // removes back button
        actions: [
          const Spacer(),
          _buildAnimatedIcon(
            icon: Icons.home,
            index: 0,
            tooltip: "Home",
          ),
          const Spacer(),
          _buildAnimatedIcon(
            icon: Icons.chat,
            index: 1,
            tooltip: "Chats",
          ),
          const Spacer(),
          _buildAnimatedIcon(
            icon: Icons.settings,
            index: 2,
            tooltip: "Settings",
          ),
          const Spacer(),
          _buildAnimatedIcon(
            icon: Icons.history,
            index: 3,
            tooltip: "Stories",
          ),
          const Spacer(),
          _buildAnimatedIcon(
            icon: Icons.person,
            index: 4,
            tooltip: "Profile",
          ),
          const Spacer(),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );

  }
  Widget _buildAnimatedIcon({
    required IconData icon,
    required int index,
    required String tooltip,
  }) {
    final bool isSelected = _currentIndex == index;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: isSelected ? 1.3 : 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: IconButton(
            highlightColor: Colors.transparent,
            icon: Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            onPressed: () => _onIconTapped(index),
            tooltip: tooltip,
          ),
        );
      },
    );
  }

}
