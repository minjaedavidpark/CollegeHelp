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

1. **Write tests** for all new features or bug fixes

2. **Run tests locally** before submitting a PR
   ```bash
   flutter test
   ```

3. **Test on multiple devices/platforms** if possible

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