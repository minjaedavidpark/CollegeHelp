import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:college_help/screens/auth/login_screen.dart';
import 'package:college_help/screens/auth/signup_screen.dart';
import 'package:college_help/screens/home/home_screen.dart';

void main() {
  // Helper function to pump the LoginScreen widget
  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
  }

  testWidgets('LoginScreen displays initial UI elements', (
    WidgetTester tester,
  ) async {
    await pumpLoginScreen(tester);

    // Verify AppBar title (specifically finding Text within AppBar)
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Login')),
      findsOneWidget,
    );

    // Verify Icon
    expect(find.byIcon(Icons.account_circle), findsOneWidget);

    // Verify TextFormFields (using label text)
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

    // Verify Buttons
    expect(find.widgetWithText(TextButton, 'Forgot Password?'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Sign Up'), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
  });

  testWidgets('Toggles password visibility', (WidgetTester tester) async {
    await pumpLoginScreen(tester);

    // Find the TextFormField by its label
    final passwordFieldFinder = find.widgetWithText(TextFormField, 'Password');
    expect(passwordFieldFinder, findsOneWidget);

    // Helper function to find the EditableText within the password field
    Finder findEditableText() {
      return find.descendant(
        of: passwordFieldFinder,
        matching: find.byType(EditableText),
      );
    }

    // Check initial obscure state on EditableText
    expect(
      tester.widget<EditableText>(findEditableText()).obscureText,
      isTrue,
      reason: "Password should initially be obscured",
    );

    // Find and tap the visibility toggle icon button
    final visibilityButton = find.byIcon(Icons.visibility);
    expect(visibilityButton, findsOneWidget);
    await tester.tap(visibilityButton);
    await tester.pump(); // Rebuild with updated state

    // Verify password is now visible by checking EditableText
    expect(
      tester.widget<EditableText>(findEditableText()).obscureText,
      isFalse,
      reason: "Password should be visible after first tap",
    );
    // Verify the icon changed
    expect(
      find.byIcon(Icons.visibility_off),
      findsOneWidget,
      reason: "Icon should change to visibility_off",
    );
    expect(
      find.byIcon(Icons.visibility),
      findsNothing,
    ); // Original icon should be gone

    // Tap again to hide
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump(); // Rebuild with updated state

    // Verify password is now hidden by checking EditableText
    expect(
      tester.widget<EditableText>(findEditableText()).obscureText,
      isTrue,
      reason: "Password should be obscured after second tap",
    );
    // Verify the icon changed back
    expect(
      find.byIcon(Icons.visibility),
      findsOneWidget,
      reason: "Icon should change back to visibility",
    );
    expect(
      find.byIcon(Icons.visibility_off),
      findsNothing,
    ); // visibility_off icon should be gone
  });

  testWidgets('Shows validation errors for empty fields on login attempt', (
    WidgetTester tester,
  ) async {
    await pumpLoginScreen(tester);

    // Tap the Login button without entering anything
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump(); // Trigger validation

    // Verify error messages are shown
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    // Verify no navigation occurred
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('Shows validation error for invalid email format', (
    WidgetTester tester,
  ) async {
    await pumpLoginScreen(tester);

    // Enter invalid email
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'invalid-email',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );

    // Tap the Login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump(); // Trigger validation

    // Verify email error message
    expect(find.text('Please enter a valid email'), findsOneWidget);
    expect(
      find.text('Please enter your password'),
      findsNothing,
    ); // Password is valid
  });

  testWidgets('Shows validation error for short password', (
    WidgetTester tester,
  ) async {
    await pumpLoginScreen(tester);

    // Enter valid email and short password
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'test@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      '123',
    );

    // Tap the Login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump(); // Trigger validation

    // Verify password error message
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    expect(
      find.text('Please enter your email'),
      findsNothing,
    ); // Email is valid
  });

  testWidgets('Navigates to HomeScreen on successful login', (
    WidgetTester tester,
  ) async {
    await pumpLoginScreen(tester);

    // Enter valid credentials
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'valid@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );

    // Tap the Login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    // Use pump, not pumpAndSettle, due to potential HomeScreen animations
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // Allow time for navigation

    // Verify navigation to HomeScreen occurred
    expect(find.byType(HomeScreen), findsOneWidget);
    // Verify LoginScreen is no longer visible (due to pushReplacement)
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('Navigates to SignUpScreen when Sign Up link is tapped', (
    WidgetTester tester,
  ) async {
    await pumpLoginScreen(tester);

    // Tap the Sign Up text button
    await tester.tap(find.widgetWithText(TextButton, 'Sign Up'));
    await tester.pumpAndSettle(); // SignUpScreen likely doesn't have animations

    // Verify navigation to SignUpScreen
    expect(find.byType(SignUpScreen), findsOneWidget);
    // Verify LoginScreen is no longer visible (due to pushReplacement)
    expect(find.byType(LoginScreen), findsNothing);
  });
}
