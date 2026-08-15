import 'package:flutter/material.dart';
import 'package:resto/core/helpers/extensions.dart';
import 'package:resto/core/routing/routes.dart';

Future<void> showRegisterSuccessDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Registration Successful'),
        content: const Text('You have successfully registered.'),
        actions: [
          TextButton(
            onPressed: () => context.pushAndRemoveUntil(Routes.rootView),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
