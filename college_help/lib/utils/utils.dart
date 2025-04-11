import 'package:flutter/material.dart';

class Utils {
  static ScaffoldFeatureController showMessageFloating({
    required BuildContext context,
    required String message,
    required IconData icon,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width * .55,
        content: Container(
          // height: 55,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 152, 152, 152),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.redAccent),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }

  static Map<String, dynamic> firebaseAuthException(String code) {
    switch (code) {
      case 'invalid-email':
        return {
          'imageError': Icons.error,
          'error': 'Invalid email, please try again',
        };
      case 'user-disabled':
        return {
          'imageError': Icons.error,
          'error': 'User disabled, try other credentials.',
        };
      case 'user-not-found':
        return {
          'imageError': Icons.error,
          'Error': 'User not found, try again or try another user',
        };
      case 'wrong-password':
        return {
          'imageError': Icons.error,
          'error': 'Incorrect password, try again.',
        };
      case 'too-many-requests':
        return {
          'imageError': Icons.error,
          'error': 'Too many requests, try again later!',
        };
      case 'user-token-expired':
        return {'imageError': Icons.error, 'error': 'expired token'};
      case 'network-request-failed':
        return {
          'imageError': Icons.error,
          'error':
              'connection error, it looks bad, wait a while and try again later',
        };
      case 'invalid-credential':
        return {
          'imageError': Icons.error,
          'error': 'Invalid credentials, try again later',
        };
      case 'operation-not-allowed':
        return {'imageError': Icons.error, 'error': 'Unauthorized operation'};
      case 'email-already-in-use':
        return {
          'imageError': Icons.error,
          'error':
              'This email is already being used, try creating an account using another email',
        };
      case 'weak-password':
        return {
          'imageError': Icons.error,
          'error':
              'Very weak password, for security reasons, try creating a stronger password.',
        };
      default:
        return {'imageError': Icons.error, 'error': 'Error'};
    }
  }
}
