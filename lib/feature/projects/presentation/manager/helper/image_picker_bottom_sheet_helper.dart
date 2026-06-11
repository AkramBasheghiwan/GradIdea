// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
// import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
// import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';
// import 'package:iconsax/iconsax.dart';

// class ImagePickerBottomSheetHelper {
//   static void show(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: AppColor.background,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(24),
//         ),
//       ),
//       builder: (_) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 15,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 50,
//                   height: 5,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                  Text(
//                   "إضافة وصف من صورة",
//                   style: AppTextStyle.bold(18),
//                 ),

//                 const SizedBox(height: 20),

//                 _buildOption(
//                   context: context,
//                   icon: Iconsax.camera,
//                   title: "التقاط صورة",
//                   onTap: () {
//                     Navigator.pop(context);
//                     context
//                         .read<UploadProjectCubit>()
//                         .scanDescription(ImageSource.camera);
//                   },
//                 ),

//                 const SizedBox(height: 12),

//                 _buildOption(
//                   context: context,
//                   icon: Icons.photo_library_outlined,
//                   title: "اختيار من المعرض",
//                   onTap: () {
//                     Navigator.pop(context);

//                     context
//                         .read<UploadProjectCubit>()
//                         .scanDescription(ImageSource.gallery);
//                   },
//                 ),

//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static Widget _buildOption({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: Colors.grey.shade100,
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 16,
//           ),
//           child: Row(
//             children: [
//               Icon(icon),

//               const SizedBox(width: 12),

//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               const Spacer(),

//               const Icon(Icons.arrow_forward_ios_rounded, size: 18),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
