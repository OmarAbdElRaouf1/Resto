import 'package:flutter/material.dart';
import 'package:resto/core/helpers/extensions.dart';
import 'package:resto/core/routing/routes.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white60),
        ),
        TextButton(
          onPressed: () {
            // Navigate to the sign-up screen
            context.pushNamed(Routes.registerView);
          },
          child: const Text(
            'Register Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
