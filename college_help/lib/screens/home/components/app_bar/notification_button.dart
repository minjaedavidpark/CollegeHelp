import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import 'app_bar_button.dart';
import '../notifications/notifications_panel.dart';

class NotificationButton extends StatelessWidget {
  final int unreadCount;
  final Function(int) onUnreadCountChanged;

  const NotificationButton({
    Key? key,
    required this.unreadCount,
    required this.onUnreadCountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBarButton(
          icon: Icons.notifications_outlined,
          tooltip: 'Notifications',
          onPressed: () => _showNotificationsPanel(context),
        ),
        // Only show badge if there are unread notifications
        if (unreadCount > 0)
          Positioned(
            right: 0,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.secondaryRed,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Center(
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showNotificationsPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return NotificationsPanel(
          unreadCount: unreadCount,
          onUnreadCountChanged: onUnreadCountChanged,
        );
      },
    );
  }
}
