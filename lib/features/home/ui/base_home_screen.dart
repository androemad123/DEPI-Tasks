import 'package:flutter/material.dart';
import 'dart:ui'; // for ImageFilter

import '../../buttons/ui/stories_screen.dart';
import '../../drag and drop/widgets/draggable_screen.dart';
import '../../facebook/ui/chat_list_screen.dart';
import '../../facebook/ui/facebook_home_base_screen.dart';
import '../../instagram/ui/instagram_home_page.dart';
import '../../notes/ui/notes_screen.dart';
import '../../sign up -in/login_screen.dart';
import '../../testing notifications/notifications_screen.dart';
import '../../to do list/ui/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> _tasks = const [
    {
      'title': 'Facebook',
      'icon': Icons.facebook_outlined,
      'screen': FacebookHomeBaseScreen(),
    },
    {
      'title': 'buttons',
      'icon': Icons.smart_button_rounded,
      'screen': buttons(),
    },
    {
      'title': 'Instagram',
      'icon': Icons.install_mobile,
      'screen': InstagramHomePage(),
    },
    {
      'title': 'Drag & Drop',
      'icon': Icons.drag_indicator,
      'screen': DraggableScreen(),
    },
    {
      'title': 'ToDo List',
      'icon': Icons.list_alt_rounded,
      'screen': TodoScreen(),
    },
    {
      'title': 'Notes with bloc',
      'icon': Icons.edit_note,
      'screen': NotesScreen(),
    },
    {
      'title': 'Login Screen',
      'icon': Icons.login_outlined,
      'screen': LoginScreen(),
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications_none_outlined,
      'screen': NotificationsScreen(),
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter Tasks'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // so background goes behind AppBar
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.png', // your background image path
            fit: BoxFit.cover,
          ),

          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.5,
              ),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => task['screen'],
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.0),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(task['icon'], color: Colors.white, size: 32),
                            const SizedBox(height: 8),
                            Text(
                              task['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
