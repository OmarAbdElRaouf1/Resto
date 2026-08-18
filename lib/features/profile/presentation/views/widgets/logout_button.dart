import 'package:flutter/material.dart';
import 'package:resto/core/helpers/extensions.dart';
import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/routing/routes.dart';
import 'package:resto/core/widgets/custom_button.dart';
import 'package:resto/features/profile/presentation/views/widgets/logout_sheet.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return LogoutSheet();
      },
    );

    if (confirmed != true || !context.mounted) return;

    await SharedPrefs.removeToken();

    if (context.mounted) {
      context.pushReplacementNamed(Routes.loginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Log out',
      color: Colors.red.shade50,
      textColor: Colors.red.shade700,
      onTap: () => _confirmLogout(context),
    );
  }
}
