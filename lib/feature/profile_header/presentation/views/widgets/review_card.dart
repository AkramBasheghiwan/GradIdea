import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/Student_home/presentation/views/widgets/build_app_card.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _item("الاسم", "أحمد محمد علي"),
          _divider(),
          _item("الإيميل", "ahmed@university.edu"),
          _divider(),
          _item("التخصص", "علوم الحاسب"),
          _divider(),
          _item("المستوى", "الثامن"),
          _divider(),
          _item("الاهتمامات", "AI / Security"),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: const Divider(color: AppColor.border, height: 1),
    );
  }

  Widget _item(String title, String value) {
    return Row(
      children: [
        Expanded(child: Text(value, style: AppTextStyle.bold(14))),
        Text(title, style: AppTextStyle.medium(13, color: AppColor.grey)),
      ],
    );
  }
}
