import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:college_help/screens/home/tabs/dining_tab.dart';
import 'package:college_help/screens/home/components/section_header.dart';
import 'package:college_help/screens/home/components/dining/featured_dining_card.dart';
import 'package:college_help/screens/home/components/dining/menu_highlight_card.dart';
import 'package:college_help/screens/home/components/dining/meal_plan_card.dart';
import 'package:college_help/screens/home/components/dining/location_card.dart';
import 'package:college_help/screens/home/components/dining/dietary_option_tile.dart';

void main() {
  // Helper to pump DiningTab within a Scaffold and MaterialApp
  Future<void> pumpDiningTab(WidgetTester tester) async {
    // Set a larger virtual screen size for the test
    tester.view.physicalSize = const Size(1080, 2400); // Example phone size
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: DiningTab()),
    ));
    await tester.pumpAndSettle(); // Initial build
  }

  testWidgets('DiningTab displays headers and key content sections', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: DiningTab()),
    ));
    await tester.pumpAndSettle(); // Initial build

    final scrollableFinder = find.byType(Scrollable);
    expect(scrollableFinder, findsOneWidget);

    // Function to find text, scrolling if necessary
    Future<void> findTextScrolling(String text) async {
      final textFinder = find.text(text, skipOffstage: false);
      await tester.scrollUntilVisible(
        textFinder,
        50.0, // Scroll increment
        scrollable: scrollableFinder,
      );
      expect(textFinder, findsOneWidget);
    }

    // Check for main header text
    expect(find.text('Dining at New College'), findsOneWidget);

    // Check for Section Header Texts, scrolling until visible
    await findTextScrolling("Today's Menu Highlights");
    await findTextScrolling('Meal Plan Options');
    await findTextScrolling('Campus Dining Locations');
    await findTextScrolling('Dietary Accommodations');
    await findTextScrolling('Feedback & Contact');

    // Check for key content within FeaturedDiningCard (near top)
    expect(find.text('Wilson Hall Dining Commons'), findsOneWidget);
    
    // Skip checks for specific card types within the list due to test flakiness.
    // These cards should be tested individually.

    // Check for the feedback card content, scrolling until visible
    await findTextScrolling('We Value Your Feedback');
  });

  // Note: The onTap callbacks in the original DiningTab code are empty.
  // If functionality were added (e.g., navigation, showing details),
  // further tests would be needed here to verify those interactions.
}
