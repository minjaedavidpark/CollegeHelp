import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import 'top_bar_wave_painter.dart';
import 'search_button.dart';
import 'help_button.dart';
import 'notification_button.dart';
import 'profile_button.dart';
import '../dialogs/search_dialog.dart';
import '../dialogs/help_dialog.dart';

class EnhancedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AnimationController animationController;
  final int unreadNotificationsCount;
  final Function(int) onUnreadCountChanged;
  final VoidCallback onProfileTap;

  const EnhancedAppBar({
    Key? key,
    required this.animationController,
    required this.unreadNotificationsCount,
    required this.onUnreadCountChanged,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF00205C), // Deeper blue
                    AppColors.primaryBlue,
                    const Color(0xFF0A3A7D), // Slightly lighter blue
                  ],
                ),
              ),
              child: CustomPaint(
                painter: TopBarWavePainter(
                  animation: animationController.value,
                ),
                child: child,
              ),
            );
          },
          child: const SizedBox.expand(),
        ),
        leadingWidth: 100, // Increased to fit two buttons with proper spacing
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SearchButton(
                onPressed: () => showSearchDialog(context),
              ),
            ),
            const SizedBox(width: 6), // Same spacing as between right buttons
            HelpButton(
              onPressed: () => showHelpDialog(context),
            ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Decorative dot
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.secondaryRed.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            // Main title text
            const Text(
              'New College',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 10),
            // Second decorative dot
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.secondaryRed.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          NotificationButton(
            unreadCount: unreadNotificationsCount,
            onUnreadCountChanged: onUnreadCountChanged,
          ),
          const SizedBox(width: 6),
          ProfileButton(
            onPressed: onProfileTap,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
