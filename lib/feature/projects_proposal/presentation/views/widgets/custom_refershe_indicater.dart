import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class CustomRefersheIndicater extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String text;
  const CustomRefersheIndicater({
    required this.text,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          Center(
            child: Text(
              text,
              style: AppTextStyle.bold(16, color: AppColor.grey),
            ),
          ),
        ],
      ),
    );
  }
}
