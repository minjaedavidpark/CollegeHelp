import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:college_help/main.dart' hide WelcomeScreen, LoginScreen, SignUpScreen; // Removed this import entirely
import 'package:college_help/screens/welcome_screen.dart';
import 'package:college_help/screens/auth/login_screen.dart';
import 'package:college_help/screens/auth/signup_screen.dart';
import 'package:college_help/screens/home/home_screen.dart';

void main() {
  testWidgets('WelcomeScreen displays logo, text, and buttons', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    // We wrap WelcomeScreen in MaterialApp to provide necessary context (like Navigator).
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    // Verify the Icon is present.
    expect(find.byIcon(Icons.school), findsOneWidget);

    // Verify the main welcome text is present.
    expect(find.text('Welcome to New College'), findsOneWidget);

    // Verify the subtitle text is present.
    expect(find.text('University of Toronto'), findsOneWidget);

    // Verify the Login button is present.
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // Verify the Sign Up button is present.
    expect(find.widgetWithText(OutlinedButton, 'Sign Up'), findsOneWidget);

    // Verify the Guest access text button is present.
    expect(
      find.widgetWithText(TextButton, 'Continue as Guest'),
      findsOneWidget,
    );
  });

  testWidgets('Tapping Login button navigates to LoginScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    // Find the Login button.
    final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');
    expect(loginButtonFinder, findsOneWidget);

    // Tap the Login button.
    await tester.tap(loginButtonFinder);
    // Wait for the navigation animation to complete.
    await tester.pumpAndSettle();

    // Verify that LoginScreen is now displayed.
    expect(find.byType(LoginScreen), findsOneWidget);
    // Verify that WelcomeScreen is no longer displayed (due to push navigation).
    expect(find.byType(WelcomeScreen), findsNothing);
  });

  testWidgets('Tapping Sign Up button navigates to SignUpScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    // Find the Sign Up button.
    final signUpButtonFinder = find.widgetWithText(OutlinedButton, 'Sign Up');
    expect(signUpButtonFinder, findsOneWidget);

    // Tap the Sign Up button.
    await tester.tap(signUpButtonFinder);
    await tester.pumpAndSettle();

    // Verify that SignUpScreen is now displayed.
    expect(find.byType(SignUpScreen), findsOneWidget);
    expect(find.byType(WelcomeScreen), findsNothing);
  });

  testWidgets('Tapping Continue as Guest button navigates to HomeScreen as guest', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    // Find the Guest button.
    final guestButtonFinder = find.widgetWithText(
      TextButton,
      'Continue as Guest',
    );
    expect(guestButtonFinder, findsOneWidget);

    // Tap the Guest button.
    await tester.tap(guestButtonFinder);
    // Pump twice to allow navigation transition to start and HomeScreen to build
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // Allow some time for build

    // Verify that HomeScreen is now displayed.
    expect(find.byType(HomeScreen), findsOneWidget);

    // Verify that the HomeScreen received the isGuest: true parameter.
    final homeScreenWidget = tester.widget<HomeScreen>(find.byType(HomeScreen));
    expect(homeScreenWidget.isGuest, isTrue);

    // Verify that WelcomeScreen is no longer displayed (due to pushReplacement).
    expect(find.byType(WelcomeScreen), findsNothing);
  });
}
