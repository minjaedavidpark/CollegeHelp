import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:college_help/screens/auth/signup_screen.dart';
import 'package:college_help/screens/auth/login_screen.dart';
import 'package:college_help/screens/home/home_screen.dart';

void main() {
  // Helper function to pump the SignUpScreen widget
  Future<void> pumpSignUpScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
  }

  // Helper function to find the EditableText within a TextFormField
  Finder findEditableTextDescendant(Finder finder) {
    return find.descendant(of: finder, matching: find.byType(EditableText));
  }

  // Helper to find specific TextFormField by label
  Finder findFieldByLabel(String label) {
    return find.widgetWithText(TextFormField, label);
  }

  testWidgets('SignUpScreen displays initial UI elements', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    expect(find.text('Create Account'), findsOneWidget); // AppBar title
    expect(findFieldByLabel('Full Name'), findsOneWidget);
    expect(findFieldByLabel('University Email'), findsOneWidget);
    expect(findFieldByLabel('Student ID'), findsOneWidget);
    expect(findFieldByLabel('Password'), findsOneWidget);
    expect(findFieldByLabel('Confirm Password'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.textContaining('Terms of Service'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Login'), findsOneWidget);
    expect(find.text('Already have an account?'), findsOneWidget);
  });

  testWidgets('Toggles password visibility for both password fields', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    final passwordField = findFieldByLabel('Password');
    final confirmPasswordField = findFieldByLabel('Confirm Password');

    // Check initial state (obscured)
    expect(
      tester
          .widget<EditableText>(findEditableTextDescendant(passwordField))
          .obscureText,
      isTrue,
    );
    expect(
      tester
          .widget<EditableText>(
            findEditableTextDescendant(confirmPasswordField),
          )
          .obscureText,
      isTrue,
    );

    // Find visibility toggle buttons (need to be more specific)
    final passwordVisibilityBtn = find.descendant(
      of: passwordField,
      matching: find.byIcon(Icons.visibility),
    );
    final confirmPasswordVisibilityBtn = find.descendant(
      of: confirmPasswordField,
      matching: find.byIcon(Icons.visibility),
    );
    expect(passwordVisibilityBtn, findsOneWidget);
    expect(confirmPasswordVisibilityBtn, findsOneWidget);

    // Tap password visibility
    await tester.tap(passwordVisibilityBtn);
    await tester.pump();
    expect(
      tester
          .widget<EditableText>(findEditableTextDescendant(passwordField))
          .obscureText,
      isFalse,
    );
    expect(
      find.descendant(
        of: passwordField,
        matching: find.byIcon(Icons.visibility_off),
      ),
      findsOneWidget,
    );

    // Tap confirm password visibility
    await tester.tap(confirmPasswordVisibilityBtn);
    await tester.pump();
    expect(
      tester
          .widget<EditableText>(
            findEditableTextDescendant(confirmPasswordField),
          )
          .obscureText,
      isFalse,
    );
    expect(
      find.descendant(
        of: confirmPasswordField,
        matching: find.byIcon(Icons.visibility_off),
      ),
      findsOneWidget,
    );

    // Tap again to hide
    await tester.tap(
      find.descendant(
        of: passwordField,
        matching: find.byIcon(Icons.visibility_off),
      ),
    );
    await tester.pump();
    expect(
      tester
          .widget<EditableText>(findEditableTextDescendant(passwordField))
          .obscureText,
      isTrue,
    );

    await tester.tap(
      find.descendant(
        of: confirmPasswordField,
        matching: find.byIcon(Icons.visibility_off),
      ),
    );
    await tester.pump();
    expect(
      tester
          .widget<EditableText>(
            findEditableTextDescendant(confirmPasswordField),
          )
          .obscureText,
      isTrue,
    );
  });

  testWidgets('Shows validation errors for empty fields on sign up attempt', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump();

    expect(find.text('Please enter your full name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your student ID'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing); // No navigation
  });

  testWidgets('Shows validation error for non-UToronto email', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    await tester.enterText(
      findFieldByLabel('University Email'),
      'test@gmail.com',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump();

    expect(find.text('Please use your UToronto email'), findsOneWidget);
  });

  testWidgets('Shows validation error for short student ID', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    await tester.enterText(findFieldByLabel('Student ID'), '12345');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump();

    expect(find.text('Student ID should be at least 8 digits'), findsOneWidget);
  });

  testWidgets('Shows validation error for short password', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    await tester.enterText(findFieldByLabel('Password'), '12345');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump();

    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });

  testWidgets('Shows validation error for password mismatch', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    await tester.enterText(findFieldByLabel('Password'), 'password123');
    await tester.enterText(findFieldByLabel('Confirm Password'), 'password456');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });

  testWidgets('Shows error if terms are not accepted', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    // Fill valid data
    await tester.enterText(findFieldByLabel('Full Name'), 'Test User');
    await tester.enterText(
      findFieldByLabel('University Email'),
      'test.user@utoronto.ca',
    );
    await tester.enterText(findFieldByLabel('Student ID'), '1001234567');
    await tester.enterText(findFieldByLabel('Password'), 'password1234');
    await tester.enterText(
      findFieldByLabel('Confirm Password'),
      'password1234',
    );

    // Uncheck the terms checkbox
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // Attempt sign up
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump(); // Pump to show SnackBar if any

    // Check for SnackBar message (this depends on implementation details)
    // Expecting SnackBar to appear
    expect(find.text('Please accept terms and conditions'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);

    // Pump again to let SnackBar potentially disappear (optional)
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('Navigates to HomeScreen on successful sign up', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    // Fill valid data
    await tester.enterText(findFieldByLabel('Full Name'), 'Test User');
    await tester.enterText(
      findFieldByLabel('University Email'),
      'test.user@utoronto.ca',
    );
    await tester.enterText(findFieldByLabel('Student ID'), '1001234567');
    await tester.enterText(findFieldByLabel('Password'), 'password1234');
    await tester.enterText(
      findFieldByLabel('Confirm Password'),
      'password1234',
    );
    // Terms are accepted by default

    // Tap Sign Up button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    // Use pump, not pumpAndSettle, due to potential HomeScreen animations
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // Allow time for navigation

    // Verify navigation to HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(SignUpScreen), findsNothing);
  });

  testWidgets('Navigates to LoginScreen when Login link is tapped', (
    WidgetTester tester,
  ) async {
    await pumpSignUpScreen(tester);

    // Find the Login text button
    final loginButtonFinder = find.widgetWithText(TextButton, 'Login');
    expect(loginButtonFinder, findsOneWidget); // Ensure it exists first

    // Scroll the button into view before tapping
    await tester.ensureVisible(loginButtonFinder);
    await tester.pumpAndSettle(); // Wait for scroll animation

    // Tap the Login text button
    await tester.tap(loginButtonFinder);
    await tester
        .pumpAndSettle(); // LoginScreen is simple, settle should be fine

    // Verify navigation to LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(SignUpScreen), findsNothing);
  });
}
