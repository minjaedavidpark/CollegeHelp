import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'auth/login_screen.dart';
import 'auth/signup_screen.dart';
import 'home/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo and welcome text
              const Icon(Icons.school, size: 80, color: AppColors.primaryBlue),
              const SizedBox(height: 24),
              const Text(
                'Welcome to New College',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'University of Toronto',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.textLight),
              ),
              const SizedBox(height: 48),

              // Login button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // Sign up button with different style
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 24),

              // Guest access text button
              TextButton(
                onPressed: () {
                  // Navigate to home screen as guest
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(isGuest: true),
                    ),
                  );
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(color: AppColors.textLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
