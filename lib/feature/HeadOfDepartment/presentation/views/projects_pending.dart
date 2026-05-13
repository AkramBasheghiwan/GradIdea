// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
// import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
// import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.background,
//       appBar: AppBar(
//         backgroundColor: Colors.white.withValues(alpha: 0.7),
//         elevation: 0,
//         centerTitle: false,
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: AppColor.primaryColor),
//           onPressed: () {},
//         ),
//         title: Text(AppStrings.appBarTitle, style: AppTextStyle.medium(22)),
//         actions: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: CircleAvatar(
//               radius: 18.r,
//               backgroundImage: const NetworkImage(
//                 "https://lh3.googleusercontent.com/aida-public/...",
//               ), // ضع الرابط من الـ HTML
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(24.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(AppStrings.mainTitle, style: AppTextStyle.headlineLarge),
//             Text(
//               AppStrings.mainSubtitle,
//               style: AppTextStyle.bodyMedium.copyWith(fontSize: 16.sp),
//             ),
//             SizedBox(height: 32.h),
//             ProjectCard(
//               id: "#2024-081",
//               title: "نظام إدارة الموارد الأكاديمية باستخدام تقنيات السحاب",
//               description:
//                   "دراسة وتطبيق لنظام متكامل يهدف إلى أتمتة العمليات الإدارية داخل الكلية باستخدام بنية تحتية سحابية هجينة.",
//               team: ["أحمد العتيبي", "سارة محمود", "فيصل خالد"],
//             ),
//             // أضف المزيد من الـ ProjectCard هنا...
//             SizedBox(height: 20.h),
//             _buildAddProjectPlaceholder(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   Widget _buildAddProjectPlaceholder() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(32.w),
//       decoration: BoxDecoration(
//         color: AppColor.primary.withValues(0.05),
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: AppColor.outlineVariant,
//           style: BorderStyle.solid,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30.r,
//             backgroundColor: Colors.white,
//             child: Icon(Icons.add, color: AppColor.primary, size: 30.sp),
//           ),
//           SizedBox(height: 16.h),
//           Text(AppStrings.addCustomProject, style: AppTextStyle.titleMedium),
//           Text(AppStrings.addProjectSubtitle, style: AppTextStyle.bodyMedium),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNav() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.9),
//         borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
//       ),
//       child: BottomNavigationBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: AppColor.primaryColor,
//         unselectedItemColor: AppColor.outlineVariant,
//         selectedLabelStyle: AppTextStyle.labelSmall.copyWith(
//           fontSize: 10.sp,
//           color: AppColor.primaryColor,
//         ),
//         items: [
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.dashboard),
//             label: AppStrings.dashboard,
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.check_circle_outline),
//             label: AppStrings.approved,
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.cancel_outlined),
//             label: AppStrings.rejected,
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.person_outline),
//             label: AppStrings.profile,
//           ),
//         ],
//       ),
//     );
//   }
// }
