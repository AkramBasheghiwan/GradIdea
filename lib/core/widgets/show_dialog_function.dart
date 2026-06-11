import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_app_confirm_dialog.dart';

class ShowDialogFunction {
  static void showAppDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String confirmText,
    String cancelText = "إلغاء",
    VoidCallback? onConfirm,
    IconData? icon,
    Color confirmColor = Colors.red,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dialog",
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return const SizedBox(); // مهم
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack, // حركة حلوة
        );

        return Transform.scale(
          scale: curved.value,
          child: Opacity(
            opacity: animation.value,
            child: Center(
              child: AppConfirmDialog(
                title: title,
                description: description,
                confirmText: confirmText,
                cancelText: cancelText,
                onConfirm: onConfirm,
                icon: icon,
                confirmColor: confirmColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
