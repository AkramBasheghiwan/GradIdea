// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
// import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
// //import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_cubit_cubit.dart';
// import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/custom_buttom.dart';
// import 'dart:ui';
// import '../../../../core/utils/app_colors.dart';

// class IdaeValidationView extends StatelessWidget {
//   const IdaeValidationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.background,
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
//         child: Column(
//           children: [
//             _buildHeroSection(),
//             SizedBox(height: 32.h),
//             _buildInputArea(),
//             SizedBox(height: 16.h),
//             _buildTipsSection(),
//             SizedBox(height: 32.h),
//             _buildSimilarityCard(),
//             SizedBox(height: 24.h),
//             _buildImprovementBox(),
//             SizedBox(height: 32.h),
//             _buildSimilarProjectsSection(),
//             SizedBox(height: 100.h), // مساحة للـ NavBar
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: AppColor.background.withValues(alpha: 0.7),
//       elevation: 0,
//       flexibleSpace: ClipRect(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(color: Colors.transparent),
//         ),
//       ),
//       title: Row(
//         children: [
//           CircleAvatar(
//             radius: 20.r,
//             backgroundImage: const NetworkImage(
//               "https://lh3.googleusercontent.com/aida-public/AB6AXuABPSPrVc2Zj7xD2vW3LzFAkGv7blPf7xUGVm-rNVAHO8g_LN9Ut_bRB5772bvrNHDfPkKm-WTsm9Empm2Ds2SsghAbpBPC-JGkt4lGS8j35fhRB8RcxmmTXlDS-MoesZvCRZX-G8a6fRLj6Z353K4RXcps3a5CdTzvJ8_1-qdjNJIVOdmgA5qkrZ4Z-_BgDj3IuINPH341Lw28m72rOsHOTrTcvfIeEC313JOC90x06OdnQYphG5UrAxbUJXqYBoB5tV75UkmB_bM",
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Text(
//             AppStrings.appName,
//             style: AppTextStyle.extraBold(20, color: AppColor.primaryColor),
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(
//             Icons.notifications_none,
//             color: AppColor.primaryColor,
//           ),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }

//   Widget _buildHeroSection() {
//     return Column(
//       children: [
//         Text(AppStrings.heroTitle, style: AppTextStyle.extraBold(32)),
//         SizedBox(height: 12.h),
//         Text(
//           AppStrings.heroSubTitle,
//           textAlign: TextAlign.center,
//           style: AppTextStyle.medium(16),
//         ),
//       ],
//     );
//   }

//   Widget _buildInputArea() {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: AppColor.white,
//         borderRadius: BorderRadius.circular(24.r),
//         boxShadow: [
//           BoxShadow(
//             color: AppColor.primaryColor.withValues(alpha: 0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.psychology, color: AppColor.primaryColor, size: 24.sp),
//               SizedBox(width: 8.w),
//               Text(
//                 AppStrings.projectDesc,
//                 style: AppTextStyle.bold(14, color: AppColor.primaryColor),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           TextField(
//             maxLines: 6,
//             decoration: InputDecoration(
//               hintText: AppStrings.inputPlaceholder,
//               hintStyle: AppTextStyle.regular(
//                 14,
//                 color: AppColor.outlineVariant,
//               ),
//               border: InputBorder.none,
//               fillColor: AppColor.background,
//               filled: true,
//               contentPadding: EdgeInsets.all(16.w),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           CustomButton(
//             text: AppStrings.checkButton,
//             icon: Icons.search,
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSimilarityCard() {
//     return Container(
//       padding: EdgeInsets.all(32.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24.r),
//         border: const Border(
//           right: BorderSide(color: AppColor.amber, width: 6),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: AppColor.amber.withValues(alpha: 0.1),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.warning_amber_rounded,
//               color: AppColor.amber,
//               size: 48,
//             ),
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             AppStrings.similarityAnalysis.toUpperCase(),
//             style: AppTextStyle.bold(12, color: AppColor.outlineVariant),
//           ),
//           Text(
//             AppStrings.semiRepeated,
//             style: AppTextStyle.extraBold(36, color: AppColor.amber),
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(AppStrings.similarityRatio, style: AppTextStyle.bold(12)),
//               Text("65%", style: AppTextStyle.bold(12)),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           LinearProgressIndicator(
//             value: 0.65,
//             backgroundColor: AppColor.surfaceContainerLow,
//             color: AppColor.amber,
//             minHeight: 8.h,
//             borderRadius: BorderRadius.circular(4.r),
//           ),
//         ],
//       ),
//     );
//   }

//   // ... (تكملة الوظائف الأخرى مثل _buildSimilarProjectsSection بنفس النمط)

//   Widget _buildBottomNavBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(32.r),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.white.withValues(alpha: 0.8),
//             selectedItemColor: AppColor.primaryColor,
//             unselectedItemColor: AppColor.outlineVariant,
//             currentIndex: 1,
//             selectedLabelStyle: AppTextStyle.bold(10),
//             unselectedLabelStyle: AppTextStyle.medium(10),
//             items: const [
//               BottomNavigationBarItem(icon: Icon(Icons.search), label: "البحث"),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.psychology),
//                 label: "المدقق الآلي",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.upload_file),
//                 label: "المرفوعات",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_outline),
//                 label: "الملف الشخصي",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTipsSection() {
//     // تطبيق الـ Grid في HTML كـ Wrap أو Column هنا
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColor.primaryColor.withValues(alpha: 0.05),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.lightbulb_outline, color: AppColor.primaryColor),
//               SizedBox(width: 8.w),
//               Text(
//                 AppStrings.notesHeader,
//                 style: AppTextStyle.bold(16, color: AppColor.primaryColor),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           _tipItem("اشرح المشكلة الأساسية التي يعالجها مشروعك"),
//           _tipItem("اذكر التقنيات البرمجية أو الهندسية المستخدمة"),
//           _tipItem("وضح القيمة المضافة وما يميزك عن غيرك"),
//         ],
//       ),
//     );
//   }

//   Widget _tipItem(String text) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4.h),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.check_circle,
//             size: 16,
//             color: AppColor.primaryColor,
//           ),
//           SizedBox(width: 8.w),
//           Expanded(child: Text(text, style: AppTextStyle.medium(13))),
//         ],
//       ),
//     );
//   }

//   Widget _buildImprovementBox() {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: AppColor.primaryColor,
//         borderRadius: BorderRadius.circular(24.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.auto_awesome, color: Colors.white),
//               SizedBox(width: 8.w),
//               Text(
//                 AppStrings.improvementTitle,
//                 style: AppTextStyle.bold(20, color: Colors.white),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             "اقترح الذكاء الاصطناعي إضافة ميزة 'الواقع المعزز' لتمييز مشروعك.",
//             style: AppTextStyle.medium(
//               14,
//               color: Colors.white.withValues(alpha: 0.8),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: AppColor.primaryColor,
//               minimumSize: Size(double.infinity, 44.h),
//             ),
//             child: Text("عرض مقترحات التطوير", style: AppTextStyle.bold(14)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSimilarProjectsSection() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 const Icon(
//                   Icons.account_tree_outlined,
//                   color: AppColor.primaryColor,
//                 ),
//                 SizedBox(width: 8.w),
//                 Text(
//                   AppStrings.similarProjectsTitle,
//                   style: AppTextStyle.extraBold(22),
//                 ),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: AppColor.primaryColor.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text(
//                 AppStrings.matchingResults,
//                 style: AppTextStyle.bold(12, color: AppColor.primaryColor),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16.h),
//         _projectCard(
//           "نظام تتبع ذكي باستخدام إنترنت الأشياء",
//           "كلية علوم الحاسب",
//           "2023",
//         ),
//         _projectCard(
//           "تطبيقات الذكاء الاصطناعي في الإمداد",
//           "كلية الهندسة",
//           "2022",
//         ),
//       ],
//     );
//   }

//   Widget _projectCard(String title, String college, String year) {
//     return Card(
//       elevation: 0,
//       margin: EdgeInsets.only(bottom: 12.h),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16.w),
//         title: Text(title, style: AppTextStyle.bold(16)),
//         subtitle: Row(
//           children: [
//             const Icon(Icons.school, size: 14),
//             SizedBox(width: 4.w),
//             Text(college),
//             SizedBox(width: 8.w),
//             const Icon(Icons.calendar_today, size: 14),
//             SizedBox(width: 4.w),
//             Text(year),
//           ],
//         ),
//         trailing: const Icon(Icons.chevron_right),
//       ),
//     );
//   }
// }
