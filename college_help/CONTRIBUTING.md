# Contributing to New College UofT App

Thank you for your interest in contributing to the New College UofT mobile application! This document provides guidelines and instructions for contributing to make the process smooth and effective.

## 🌟 Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

## 🔄 Development Workflow

### 1. Setting Up the Development Environment

1. **Fork the Repository**
   - Click the "Fork" button at the top-right of the repository page.

2. **Clone Your Fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/college_help.git
   cd college_help
   ```

3. **Add Upstream Remote**
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/college_help.git
   ```

4. **Install Dependencies**
   ```bash
   flutter pub get
   ```

### 2. Making Changes

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Write Code**
   - Follow the code style guidelines below.
   - Make your changes in your branch.
   - Add comprehensive comments.

3. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Descriptive commit message"
   ```
   
   Commit messages should:
   - Start with a verb (Add, Update, Fix, Refactor)
   - Be concise but descriptive
   - Reference issues if applicable (#123)

4. **Stay Updated**
   ```bash
   git pull upstream main
   ```

5. **Push Your Changes**
   ```bash
   git push origin feature/your-feature-name
   ```

### 3. Submitting a Pull Request

1. Go to your fork on GitHub
2. Click "Pull Request"
3. Fill in the PR template
4. Reference any relevant issues
5. Wait for a review from maintainers

## 💻 Code Style Guidelines

### Flutter & Dart Guidelines

1. **Follow Dart's Official Style Guide**: [Effective Dart](https://dart.dev/guides/language/effective-dart/style)

2. **Naming Conventions**
   - `UpperCamelCase` for classes, enums, typedefs, and extensions
   - `lowerCamelCase` for variables, methods, and functions
   - `snake_case` for file names

3. **Widget Structure**
   ```dart
   class MyWidget extends StatelessWidget {
     // Final variables at the top
     final String title;
     
     // Constructor comes next
     const MyWidget({Key? key, required this.title}) : super(key: key);
     
     // Build method after that
     @override
     Widget build(BuildContext context) {
       // Method implementation
     }
     
     // Helper methods last
     Widget _buildSection() {
       // Method implementation
     }
   }
   ```

4. **Use const where possible** for better performance

5. **Prefer named parameters** for better code readability

6. **Importing Order**
   ```dart
   // Dart imports
   import 'dart:async';
   
   // Flutter imports
   import 'package:flutter/material.dart';
   
   // Third-party packages
   import 'package:provider/provider.dart';
   
   // App imports
   import 'package:college_help/constants/app_colors.dart';
   ```

7. **Comments**: Use `///` for documentation comments and `//` for implementation comments

### Architecture Guidelines

1. **Follow the established architecture** outlined in the README

2. **Keep UI separate from business logic**

3. **Make components reusable** when possible

4. **Use models** for structured data

## 🧪 Testing Guidelines

We aim for good test coverage to ensure app stability and maintainability. Please follow these guidelines when adding or modifying tests.

### Test Directory Structure

Tests should reside in the `college_help/test/` directory. The structure within `test/` should mirror the structure of the `college_help/lib/` directory.

Example:
- Code for `lib/screens/auth/login_screen.dart` should have tests in `test/screens/auth/login_screen_test.dart`.
- Code for `lib/widgets/custom_button.dart` should have tests in `test/widgets/custom_button_test.dart`.

### Types of Tests

We primarily use **Widget Tests** for testing UI components (screens, widgets). Unit tests can be used for non-UI logic (models, services if they existed).

### Writing Widget Tests

Widget tests verify that a widget's UI looks and behaves as expected.

1.  **Setup**: Import necessary packages (`flutter_test`, `flutter`, your widget's file). Wrap your widget in `MaterialApp` (or `Scaffold` if appropriate) within `tester.pumpWidget()` to provide necessary context (like `Navigator`, `Theme`).
2.  **Find**: Use `find` methods (e.g., `find.text()`, `find.byType()`, `find.byKey()`, `find.byIcon()`, `find.widgetWithText()`, `find.descendant()`) to locate widgets in the tree.
3.  **Interact**: Use `tester` methods (e.g., `tester.tap()`, `tester.enterText()`, `tester.drag()`, `tester.ensureVisible()`) to simulate user interactions.
4.  **Pump**: Use `tester.pump()` or `tester.pumpAndSettle()` after interactions to rebuild the widget tree and process animations/futures.
    *   `pump()`: Advances the clock by one frame (or a specified duration). Use when you need fine-grained control or to avoid timeouts with infinite animations.
    *   `pumpAndSettle()`: Repeatedly calls `pump()` until the frame settles (no more frames scheduled). Useful for waiting for animations or futures to complete, but can time out if animations don't finish (e.g., repeating animations).
5.  **Assert**: Use `expect()` with `Matcher`s (e.g., `findsOneWidget`, `findsNothing`, `isTrue`, `isFalse`) to verify the state of the UI.

### Example Widget Test (Simplified)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:college_help/screens/welcome_screen.dart';

void main() {
  testWidgets('WelcomeScreen shows title and login button', (WidgetTester tester) async {
    // Setup: Pump the widget within MaterialApp
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    // Find: Locate widgets
    final titleFinder = find.text('Welcome to New College');
    final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');

    // Assert: Verify widgets are present
    expect(titleFinder, findsOneWidget);
    expect(loginButtonFinder, findsOneWidget);

    // Interact: Tap the login button (Example of interaction)
    // await tester.tap(loginButtonFinder);
    // await tester.pumpAndSettle(); // or tester.pump();

    // Assert: Verify outcome of interaction (e.g., navigation)
    // expect(find.byType(LoginScreen), findsOneWidget);
  });
}
```

### Running Tests

Run all tests from the `college_help` directory:

```bash
flutter test
```

Run tests in a specific file:

```bash
flutter test test/screens/auth/login_screen_test.dart
```

### General Guidelines

1.  **Write tests** for all new features or bug fixes.
2.  Ensure tests cover common use cases, edge cases, and validation logic.
3.  Run tests locally **before** submitting a Pull Request to ensure they pass.
4.  Test on multiple devices/platforms if possible, especially for UI-heavy features.

## 📝 Documentation Guidelines

1. **Document all public APIs, classes, and methods**

2. **Update README** with any new features or changes to installation/usage

3. **Include code examples** for complex features

## 🐞 Reporting Bugs

1. **Use the issue tracker**

2. **Describe the bug in detail**:
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Screenshots if applicable
   - Device/environment information

3. **Label issues appropriately**

## 💡 Feature Requests

1. **First, check existing issues** to avoid duplicates

2. **Be specific about the problem** the feature will solve

3. **Provide examples of use cases**

4. **Suggest implementation details** if possible

## 👩‍💻 For New College Students

We especially welcome contributions from New College students! If you're new to coding or open source:

1. **Look for "good first issue" labels** in the issue tracker

2. **Ask questions** in the comments of issues you'd like to work on

3. **Pair program** with experienced contributors when possible

4. **Contribute to documentation** if you're not ready for code contributions

## 📞 Contact

If you have questions about contributing that aren't covered here, please reach out:

- **Project Maintainer**: [Name](mailto:email@example.com)
- **New College IT Services**: [newcollege.it@utoronto.ca](mailto:newcollege.it@utoronto.ca)

Thank you for making the New College UofT App better for all students! 