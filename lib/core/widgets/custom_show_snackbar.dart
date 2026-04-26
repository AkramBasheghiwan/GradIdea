import 'dart:ui';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    final overlay = Overlay.of(context);

    late Color startColor;
    late Color endColor;
    late IconData icon;

    switch (type) {
      case SnackBarType.success:
        startColor = Colors.green;
        endColor = Colors.greenAccent;
        icon = Icons.check_circle;
        break;
      case SnackBarType.error:
        startColor = Colors.red;
        endColor = Colors.redAccent;
        icon = Icons.error;
        break;
      case SnackBarType.warning:
        startColor = Colors.orange;
        endColor = Colors.deepOrange;
        icon = Icons.warning;
        break;
      case SnackBarType.info:
        startColor = Colors.blue;
        endColor = Colors.lightBlueAccent;
        icon = Icons.info;
        break;
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedSnackBar(
        message: message,
        icon: icon,
        startColor: startColor,
        endColor: endColor,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

class _AnimatedSnackBar extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color startColor;
  final Color endColor;

  const _AnimatedSnackBar({
    required this.message,
    required this.icon,
    required this.startColor,
    required this.endColor,
  });

  @override
  State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.startColor.withValues(alpha:  0.8),
                        widget.endColor.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: widget.startColor.withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(widget.icon, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}