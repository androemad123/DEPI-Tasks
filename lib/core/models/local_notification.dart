class LocalNotification {
  final String title;
  final String body;
  final String? route;
  final DateTime timestamp;

  LocalNotification({
    required this.title,
    required this.body,
    this.route,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
