import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          NotificationTile(
            title: 'Event Reminder',
            message: 'Don’t forget about the New College town hall meeting at 5 PM today!',
          ),
          NotificationTile(
            title: 'Assignment Due',
            message: 'Your CS assignment is due tomorrow at 11:59 PM.',
          ),
          NotificationTile(
            title: 'New Message',
            message: 'You received a message from the student council.',
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;

  const NotificationTile({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // You can implement further actions here
        },
      ),
    );
  }
}
