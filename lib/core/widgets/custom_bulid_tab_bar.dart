import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBulidTabBar extends StatelessWidget {
  final List<Tab> tap;
  const CustomBulidTabBar({required this.tap, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Container(
        padding: EdgeInsets.all(3.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppDimens.r30.r),
        ),
        child: TabBar(
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColor.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimens.r30.r),
          ),
          dividerColor: AppColor.transparent,
          labelColor: AppColor.activeColor,
          unselectedLabelColor: AppColor.textSecondary,
          isScrollable: true,

          tabs: tap,
        ),
      ).animate().slideX(begin: 1, end: 0),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
// import 'package:graduation_management_idea_system/core/utils/app_dimens.dart';

// class CustomBulidTabBar extends StatelessWidget {
//   final List<Tab> tap;

//   const CustomBulidTabBar({
//     super.key,
//     required this.tap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 58.h,
//       child: Container(
//         padding: EdgeInsets.all(5.r),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(
//             AppDimens.r30.r,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: .05),
//               blurRadius: 24,
//               offset: const Offset(0, 10),
//             ),
//           ],
//           border: Border.all(
//             color: Colors.grey.withValues(alpha: .08),
//           ),
//         ),
//         child: TabBar(
//           isScrollable: true,
//           tabAlignment: TabAlignment.start,

//           dividerColor: Colors.transparent,

//           indicatorSize: TabBarIndicatorSize.tab,
//           indicator: BoxDecoration(
//             gradient: AppColor.primaryGradient,
//             borderRadius: BorderRadius.circular(
//               AppDimens.r30.r,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColor.primaryColor
//                     .withValues(alpha: .25),
//                 blurRadius: 14,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),

//           labelColor: Colors.white,
//           unselectedLabelColor: AppColor.textSecondary,

//           labelStyle: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w700,
//           ),
//           unselectedLabelStyle: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//           ),

//           splashBorderRadius: BorderRadius.circular(
//             30.r,
//           ),

//           overlayColor:
//               WidgetStateProperty.all(
//                 Colors.transparent,
//               ),

//           indicatorPadding: EdgeInsets.symmetric(
//             horizontal: 2.w,
//             vertical: 2.h,
//           ),

//           tabs: tap,
//         ),
//       ).animate().fadeIn().slideY(
//         begin: .25,
//         end: 0,
//         duration: 450.ms,
//       ),
//     );
//   }
// }