import 'package:flutter/material.dart';
import 'package:resto/core/helpers/extensions.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Colors.white60),
        ),
        TextButton(
          onPressed: () {
            // Navigate to the login screen
            context.pop();
          },
          child: const Text('Login Now', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
