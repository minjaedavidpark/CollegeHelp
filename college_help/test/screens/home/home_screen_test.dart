import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:college_help/screens/home/home_screen.dart';
import 'package:college_help/screens/home/components/app_bar/enhanced_app_bar.dart';
import 'package:college_help/screens/home/tabs/home_tab.dart'; // Initial tab
import 'package:college_help/screens/home/tabs/dining_tab.dart';
import 'package:college_help/screens/home/tabs/residence_tab.dart';
import 'package:college_help/screens/home/tabs/events_tab.dart';
import 'package:college_help/screens/home/tabs/registrar_tab.dart';

void main() {
  // Helper function to pump the HomeScreen widget
  Future<void> pumpHomeScreen(
    WidgetTester tester, {
    bool isGuest = false,
  }) async {
    // Wrap in MaterialApp for Navigator, Theme, etc.
    await tester.pumpWidget(MaterialApp(home: HomeScreen(isGuest: isGuest)));
    // Pump again to ensure initial frame is built, especially with stateful widgets
    await tester.pump();
  }

  testWidgets(
    'HomeScreen displays initial layout (AppBar, HomeTab, BottomNav)',
    (WidgetTester tester) async {
      await pumpHomeScreen(tester);

      // Verify EnhancedAppBar is present
      expect(find.byType(EnhancedAppBar), findsOneWidget);

      // Verify the initial tab (HomeTab) is displayed in the PageView
      // We find the PageView first
      final pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);
      // Then check that HomeTab is a descendant of PageView
      expect(
        find.descendant(of: pageViewFinder, matching: find.byType(HomeTab)),
        findsOneWidget,
      );

      // Verify BottomNavigationBar is present
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify initial BottomNav item ("Home") is selected
      // Find the Home icon button within the BottomNavigationBar
      final homeIconFinder = find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.byIcon(Icons.home), // Use the active icon
      );
      expect(homeIconFinder, findsOneWidget);
    },
  );

  testWidgets('Tapping BottomNav items switches tabs in PageView', (WidgetTester tester) async {
    await pumpHomeScreen(tester);

    // Helper to tap a BottomNav item by its active icon and verify the corresponding tab
    Future<void> tapNavAndVerifyTab(IconData icon, Type tabType, int expectedIndex) async {
      final List<String> tabTitles = [
        'Home', 'Dining', 'Residence', 'Events', 'Registrar\'s Office',
      ];
      final tapTarget = find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(tabTitles[expectedIndex]),
      );
      
      await tester.ensureVisible(tapTarget);
      await tester.pump(const Duration(milliseconds: 500)); 
      await tester.pump(); 

      await tester.tap(tapTarget);

      // Pump repeatedly until the page index is close to the target or timeout occurs
      int pumpCount = 0;
      const maxPumps = 100; // ~5 seconds timeout
      const pumpInterval = Duration(milliseconds: 50);
      bool targetReached = false;
      while (pumpCount < maxPumps) {
          await tester.pump(pumpInterval); // Pump for the interval
          // Re-read the controller's state *after* pumping
          final currentPage = tester.widget<PageView>(find.byType(PageView)).controller!.page!;
          // Check if close enough to target index (using tolerance for double)
          if ( (currentPage - expectedIndex).abs() < 0.01 ) { 
              targetReached = true;
              break; // Exit loop once target is reached
          }
          pumpCount++;
      }

      // Assert that the target was reached within the timeout
      expect(targetReached, isTrue, 
          reason: 'PageView did not reach index $expectedIndex within ${maxPumps * pumpInterval.inMilliseconds}ms after tapping ${tabTitles[expectedIndex]} item.');

      // Optional: Final pump to ensure any final frame settles after reaching the target
      await tester.pump(); 

      // Verify the PageView controller index (redundant check, ensures stability)
      final pageViewWidget = tester.widget<PageView>(find.byType(PageView));
      expect(pageViewWidget.controller!.page!.round(), expectedIndex, 
             reason: 'Final check: Expected PageView index to be $expectedIndex');

      // Verify the correct nav item icon is now active
      final activeNavItemFinder = find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.byIcon(icon), // Use the active icon
      );
      expect(activeNavItemFinder, findsOneWidget, 
             reason: 'Expected ${icon.toString()} icon to be active in BottomNav');
    }

    // Initial state check (Index 0)
    // Use null assertion (!) on controller and page, then round
    expect(tester.widget<PageView>(find.byType(PageView)).controller!.page!.round(), 0);

    // Tap Dining (Index 1)
    await tapNavAndVerifyTab(Icons.restaurant, DiningTab, 1);
    // Tap Residence (Index 2)
    await tapNavAndVerifyTab(Icons.apartment, ResidenceTab, 2);
    // Tap Events (Index 3)
    await tapNavAndVerifyTab(Icons.event, EventsTab, 3);
    // Tap Registrar (Index 4)
    await tapNavAndVerifyTab(Icons.school, RegistrarTab, 4);
    // Tap Home again (Index 0)
    await tapNavAndVerifyTab(Icons.home, HomeTab, 0);
  });

  // TODO: Add tests for AppBar actions (Notifications, Profile Drawer)
  // TODO: Add tests for guest mode vs logged-in mode differences if any (passed via constructor)
  // TODO: Add tests for interactions within the tabs themselves (e.g., HomeTab's onViewAll)
}
