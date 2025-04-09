import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:college_help/screens/home/components/app_bar/enhanced_app_bar.dart';
import 'package:college_help/screens/home/components/profile/profile_menu.dart';

void main() {
  late AnimationController _animationController;

  // Set up AnimationController before tests
  setUpAll(() {
    // We need a TickerProvider for the AnimationController.
    // Create a simple TickerProvider using a binding mixin.
    final vsync = TestVSync();
    _animationController = AnimationController(
      vsync: vsync, // Provide the TickerProvider
      duration: const Duration(seconds: 20),
    ); // DO NOT call repeat()
  });

  // Stop controller after each test
  tearDown(() {
    // Stop the controller cleanly after each test to avoid errors
    _animationController.stop(canceled: false); 
  });

  // Dispose controller after all tests
  tearDownAll(() {
    // No need to stop again, just dispose
    _animationController.dispose();
  });

  // Helper to pump EnhancedAppBar within Scaffold/MaterialApp
  Future<void> pumpAppBar(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: EnhancedAppBar(
            animationController: _animationController,
            unreadNotificationsCount: 2, // Example count
            onUnreadCountChanged: (count) {}, // Mock callback
            onProfileTap: () {}, // Mock callback (will be overridden below)
          ),
          // Add a ProfileMenu drawer for testing the interaction
          endDrawer: ProfileMenu(onLogout: () {}),
        ),
      ),
    );
    // Pump necessary frames for initial build
    await tester.pump();
  }

  testWidgets('EnhancedAppBar displays initial elements (icons, badge text)', (WidgetTester tester) async {
    await pumpAppBar(tester);

    // Check for Notification icon
    expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    
    // Check for Badge Text (directly finding the '2')
    // Ensure it's associated with the NotificationButton area if needed, but direct find is often sufficient
    expect(find.text('2'), findsOneWidget);

    // Check for Profile icon
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
  });

  testWidgets('Tapping profile icon opens the endDrawer (ProfileMenu)', (
    WidgetTester tester,
  ) async {
    // We need to override the onProfileTap to actually open the drawer
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: scaffoldKey, // Assign key to access Scaffold state
          appBar: EnhancedAppBar(
            animationController: _animationController,
            unreadNotificationsCount: 0,
            onUnreadCountChanged: (count) {},
            // Use the Scaffold key to open the drawer
            onProfileTap: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
          endDrawer: ProfileMenu(onLogout: () {}),
        ),
      ),
    );
    await tester.pump(); // Initial frame

    // Find the profile icon button (Corrected)
    final profileButton = find.byIcon(Icons.person_outline);
    expect(profileButton, findsOneWidget);

    // Verify drawer is initially closed
    expect(
      find.byType(ProfileMenu),
      findsNothing,
    ); // Drawer isn't built until opened

    // Tap the profile button
    await tester.tap(profileButton);
    // Use pump() because opening the drawer involves animation, and we have a repeating animation
    await tester.pump(); // Start animation
    await tester.pump(const Duration(seconds: 1)); // Allow animation time

    // Verify ProfileMenu is now visible (drawer is open)
    expect(find.byType(ProfileMenu), findsOneWidget);
  });

  // TODO: Add test for tapping notification icon (if it has behavior)
  // TODO: Add test for onUnreadCountChanged callback (might require mocking)
}
