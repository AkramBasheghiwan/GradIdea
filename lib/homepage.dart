// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Project {
//   final String id;
//   final String title;
//   final String description;
//   final List<String> team;
//   final String status;

//   Project({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.team,
//     required this.status,
//   });
// }

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<Project> projects = [
//       Project(
//         id: "#2024-081",
//         title: "نظام إدارة الموارد الأكاديمية باستخدام تقنيات السحاب",
//         description:
//             "دراسة وتطبيق لنظام متكامل يهدف إلى أتمتة العمليات الإدارية داخل الكلية باستخدام بنية تحتية سحابية هجينة.",
//         team: ["أحمد العتيبي", "سارة محمود", "فيصل خالد"],
//         status: "قيد الانتظار",
//       ),
//       Project(
//         id: "#2024-114",
//         title: "تحليل بيانات التعلم الآلي للكشف المبكر عن الأمراض",
//         description:
//             "مشروع بحثي يهدف إلى تطوير خوارزميات تعلم آلي دقيقة لتحليل الصور الطبية وتوقع النتائج التشخيصية.",
//         team: ["نورا الصالح", "محمد إبراهيم"],
//         status: "قيد الانتظار",
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9FF),
//       extendBodyBehindAppBar: true,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: ClipRRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//             child: AppBar(
//               backgroundColor: Colors.white.withValues(alpha: 0.7),
//               elevation: 0,
//               leading: IconButton(
//                 icon: const Icon(Icons.menu, color: Color(0xFF3525CD)),
//                 onPressed: () {},
//               ),
//               title: Text(
//                 'رئيس القسم',
//                 style: GoogleFonts.cairo(
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xFF141B2B),
//                 ),
//               ),
//               actions: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: CircleAvatar(
//                     backgroundImage: NetworkImage(
//                       'https://lh3.googleusercontent.com/aida-public/AB6AXuDFamVnld80N--82djaOOfUjRETdVbxwduq0ycxYmDIgWe11p59yzJis5ZCxFZExg1ullRlusAcW1pf5hXLH6q6miGwxNJzret7X14vomxvu102qcSI1cp0tj4YcFDNnVBEf00pLiyd3SLj8Bvdhbuc5-n0VMRS52LV7Yw_f-RGSVYFxRdTpyhVsiXvs7XySFJsTL6RXwdY_I3e-ztkqWld3pSO0A_iFxEOJcxcZrWhl24ymL8oB6iZOhX1xOpRTmWKSOIH2ysO8dI',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(20, 120, 20, 100),
//           children: [
//             const Text(
//               'قائمة المشاريع المعلقة',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF141B2B),
//               ),
//             ),
//             const Text(
//               'بانتظار المراجعة والاعتماد النهائي',
//               style: TextStyle(fontSize: 16, color: Color(0xFF464555)),
//             ),
//             const SizedBox(height: 30),
//             ...projects.map((p) => ProjectCard(project: p)),
//             const AddProjectCard(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNav(),
//     );
//   }
// }

// class ProjectCard extends StatelessWidget {
//   final Project project;
//   const ProjectCard({super.key, required this.project});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF141B2B).withValues(alpha: 0.06),
//             blurRadius: 24,
//             offset: const Offset(0, 12),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Container(
//                 width: 6,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Color(0xFF3525CD), Color(0xFF4F46E5)],
//                   ),
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(24),
//                     bottomRight: Radius.circular(24),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFFDBCC),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.pending,
//                             size: 14,
//                             color: Color(0xFF351000),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             project.status,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF351000),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       project.id,
//                       style: const TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   project.title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   project.description,
//                   style: const TextStyle(
//                     color: Color(0xFF464555),
//                     fontSize: 14,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "فريق العمل",
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Wrap(
//                   spacing: 8,
//                   children: project.team
//                       .map(
//                         (name) => Chip(
//                           label: Text(
//                             name,
//                             style: const TextStyle(fontSize: 11),
//                           ),
//                           backgroundColor: const Color(
//                             0xFF39B8FD,
//                           ).withValues(alpha: 0.1),
//                           side: BorderSide.none,
//                           shape: const StadiumBorder(),
//                         ),
//                       )
//                       .toList(),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                   child: Divider(
//                     color: Color.fromARGB(191, 224, 224, 224),
//                     thickness: 1,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.chevron_left),
//                     label: const Text("عرض التفاصيل"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3525CD),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 12,
//                       ),
//                       shape: const StadiumBorder(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AddProjectCard extends StatelessWidget {
//   const AddProjectCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(32),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F3FF),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(
//           color: const Color(0xFFC7C4D8),
//           style: BorderStyle.solid,
//           width: 2,
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//               color: Color(0xFFDCE2F7),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.add, color: Color(0xFF3525CD), size: 32),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             "إضافة مشروع مخصص",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           const Text(
//             "أرشفة مشروع يدوي في النظام",
//             style: TextStyle(color: Colors.grey, fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomBottomNav extends StatelessWidget {
//   const CustomBottomNav({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 90,
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.7),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 20,
//             offset: const Offset(0, -10),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               NavItem(
//                 icon: Icons.dashboard,
//                 label: "Dashboard",
//                 isActive: true,
//               ),
//               NavItem(icon: Icons.check_circle_outline, label: "Approved"),
//               NavItem(icon: Icons.cancel_outlined, label: "Rejected"),
//               NavItem(icon: Icons.person_outline, label: "Profile"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isActive;
//   const NavItem({
//     super.key,
//     required this.icon,
//     required this.label,
//     this.isActive = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: isActive
//               ? BoxDecoration(
//                   color: const Color(0xFF3525CD).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(16),
//                 )
//               : null,
//           child: Icon(
//             icon,
//             color: isActive ? const Color(0xFF3525CD) : Colors.grey,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             color: isActive ? const Color(0xFF3525CD) : Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }
