import 'package:flutter/material.dart';
import '../../core/models/local_notification.dart';
import '../../core/services/firebase_messeging.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final FirebaseNotification _service;

  @override
  void initState() {
    super.initState();
    _service = FirebaseNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: StreamBuilder<List<LocalNotification>>(
        stream: _service.notificationsStream,
        initialData: _service.notifications,
        builder: (context, snapshot) {
          final notifs = snapshot.data ?? [];

          if (notifs.isEmpty) {
            return const Center(child: Text("No notifications yet"));
          }

          return ListView.builder(
            itemCount: notifs.length,
            itemBuilder: (context, index) {
              final notif = notifs[index];
              return ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(notif.title),
                subtitle: Text(notif.body),
                trailing: Text(
                  "${notif.timestamp.hour}:${notif.timestamp.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  if (notif.route != null) {
                    Navigator.pushNamed(context, notif.route!);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
