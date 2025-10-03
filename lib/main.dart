import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'core/services/firebase_messeging.dart';
import 'features/home/ui/base_home_screen.dart';
import 'features/notes/data/bloc/note_bloc.dart';
import 'features/testing notifications/notifications_screen.dart';
import 'features/to do list/data/todo_provider.dart';

// If you used `flutterfire configure`, also import this
// import 'firebase_options.dart';
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseNotification.firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap
      if (response.payload != null) {
        if (response.payload == "notifications") {
          navigatorKey.currentState?.pushNamed('/notifications');
        } else if (response.payload == "home") {
          navigatorKey.currentState?.pushNamed('/home');
        }
      }
    },
  );
  // Init service
  await FirebaseNotification().init();

  runApp(const DepiTasks());
}

class DepiTasks extends StatelessWidget {
  const DepiTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        BlocProvider(create: (_) => NoteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Depi Tasks',
        navigatorKey: navigatorKey, // 👈 enable global navigation
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/notifications': (context) => const NotificationsScreen(),
        },
      ),
    );
  }
}

