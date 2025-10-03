import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

import '../models/local_notification.dart';

class FirebaseNotification {
  // Singleton instance to ensure only one service is used across the app
  static final FirebaseNotification _instance =
  FirebaseNotification._internal();
  factory FirebaseNotification() => _instance;
  FirebaseNotification._internal();

  // Firebase Messaging instance to interact with FCM
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Local notifications plugin to display notifications inside the app
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Stream for raw FCM messages
  final StreamController<RemoteMessage> _messageStreamController =
  StreamController.broadcast();
  Stream<RemoteMessage> get firebaseStream =>
      _messageStreamController.stream;

  // In-memory list to store local notifications
  final List<LocalNotification> _localNotifications = [];
  List<LocalNotification> get notifications =>
      List.unmodifiable(_localNotifications);

  // Stream for local notifications so UI can listen for updates
  final StreamController<List<LocalNotification>>
  _notificationStreamController =
  StreamController.broadcast();
  Stream<List<LocalNotification>> get notificationsStream =>
      _notificationStreamController.stream;

  /// Initialize Firebase Messaging & Local Notifications
  Future<void> init() async {
    // Request notification permissions from the user
    await _requestPermission();

    // Initialize local notifications plugin with Android settings
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidInit);

    await _localNotificationsPlugin.initialize(initSettings);

    // Listen for foreground push notifications
    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    // Listen for taps on notifications when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Handle notification that launched the app (terminated state)
    RemoteMessage? initialMessage =
    await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(initialMessage);
    }
  }

  /// Ask for notification permissions
  Future<void> _requestPermission() async {
    // Request notification permissions (alerts, badges, sounds)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint("Permission granted: ${settings.authorizationStatus}");
  }

  /// Handle foreground messages
  Future<void> _onMessageHandler(RemoteMessage message) async {
    // Extract notification title, body, and optional route
    RemoteNotification? notification = message.notification;
    String title = notification?.title ?? message.data['title'] ?? "No Title";
    String body = notification?.body ?? message.data['body'] ?? "No Body";
    String? route = message.data['route'];

    // Save notification locally in memory
    final local = LocalNotification(
      title: title,
      body: body,
      route: route,
    );
    _localNotifications.insert(0, local); // Add to top of list
    _notificationStreamController.add(_localNotifications);

    // Show notification in system tray (Android)
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      notification?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
      title,
      body,
      platformDetails,
      payload: route,
    );

    // Push raw message into stream for listeners
    _messageStreamController.add(message);
  }

  /// Handle background notification taps
  void _onMessageOpenedApp(RemoteMessage message) {
    // Navigate to specific route when notification is tapped
    _handleMessageNavigation(message);
  }

  /// Navigation logic when notification tapped
  void _handleMessageNavigation(RemoteMessage message) {
    // Extract the navigation route from message data
    String? route = message.data['route'];
    debugPrint("Navigate to route: $route");

    // Example navigation if you set up navigatorKey in main.dart
    // if (route != null) {
    //   navigatorKey.currentState?.pushNamed(route);
    // }
  }

  /// Get FCM token for this device
  Future<String?> getDeviceToken() async {
    // Fetch unique FCM token for current device
    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");
    return token;
  }

  /// Handle background messages (must be top-level or static)
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Ensure Firebase is initialized before processing background message
    await Firebase.initializeApp();
    debugPrint("Handling a background message: ${message.messageId}");
  }
}
