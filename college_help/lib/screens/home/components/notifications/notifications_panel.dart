import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import 'notification_item.dart';

class NotificationsPanel extends StatefulWidget {
  final int unreadCount;
  final Function(int) onUnreadCountChanged;

  const NotificationsPanel({
    Key? key,
    required this.unreadCount,
    required this.onUnreadCountChanged,
  }) : super(key: key);

  @override
  _NotificationsPanelState createState() => _NotificationsPanelState();
}

class _NotificationsPanelState extends State<NotificationsPanel> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Assignment Due',
      'message': 'Your CS 101 assignment is due tomorrow at 11:59 PM.',
      'time': '1 hour ago',
      'isRead': false,
      'type': 'academic',
    },
    {
      'title': 'Campus Event',
      'message': 'Spring Fling begins this Friday at the Main Quad!',
      'time': '3 hours ago',
      'isRead': false,
      'type': 'event',
    },
    {
      'title': 'New Announcement',
      'message': 'Professor Williams has canceled class for tomorrow.',
      'time': 'Yesterday',
      'isRead': true,
      'type': 'academic',
    },
    {
      'title': 'System Update',
      'message': 'CollegeHelp app has been updated to version 2.3.',
      'time': '2 days ago',
      'isRead': true,
      'type': 'system',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildTabsAndContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notifications',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
          ),
          TextButton(
            onPressed: () {
              // Mark all as read
              setState(() {
                for (var notification in _notifications) {
                  notification['isRead'] = true;
                }
              });
              widget.onUnreadCountChanged(0);
            },
            child: Text(
              'Mark all as read',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsAndContent(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primaryBlue,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Academic'),
                Tab(text: 'Events'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildNotificationList(_notifications),
                  _buildNotificationList(_notifications
                      .where((n) => n['type'] == 'academic')
                      .toList()),
                  _buildNotificationList(
                      _notifications.where((n) => n['type'] == 'event').toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return const Center(
        child: Text(
          'No notifications',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationItem(
          title: notification['title'],
          message: notification['message'],
          time: notification['time'],
          isRead: notification['isRead'],
          onTap: () {
            setState(() {
              if (!notification['isRead']) {
                notification['isRead'] = true;
                int newUnreadCount = _notifications
                    .where((n) => n['isRead'] == false)
                    .length;
                widget.onUnreadCountChanged(newUnreadCount);
              }
            });
          },
        );
      },
    );
  }
}
