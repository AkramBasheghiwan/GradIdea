import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_strings.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/admin_dashboard/presentation/views/widgets/action_card.dart';
import 'package:graduation_management_idea_system/feature/admin_dashboard/presentation/views/widgets/custom_start_item_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // Ambient light effect simulation
          Positioned(
            top: -100.h,
            left: -100.w,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColor.primaryColor.withValues(alpha: 0.05),
                    AppColor.background.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('', trailing: ''),
                        SizedBox(height: 16.h),
                        _buildMainStatCard(),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: AppStrings.deptHeads,
                                value: "12",
                                icon: Icons.groups_outlined,
                                iconColor: AppColor.primaryColor,
                                bgColor: AppColor.activeColor.withValues(
                                  alpha: 0.30,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: StatCard(
                                title: AppStrings.archivedProjects,
                                value: "450",
                                icon: Icons.inventory_2_outlined,
                                iconColor: AppColor.textSecondary,
                                bgColor: AppColor.primaryColor.withValues(
                                  alpha: 0.30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        _buildSectionTitle(AppStrings.quickControl),
                        SizedBox(height: 16.h),
                        const ActionCard(
                          title: 'اداره المستخدمين',
                          description: '',
                          linkText: AppStrings.startNow,
                          imageUrl:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuCEiU6ntMl5Vxsjf8NUK6IOAncOT-3xW3utFKNmPOI__qLqVdJy6nTmEjg78lQL9lLtP57SzhpEEaJcOcegPw2SEpij2_DpuJMz4Fcr1BvgcjHoOnmyMmfHHvPBhtEYqB00mHQAcciEDZ4zap9AcQycvEgaEzWNlmnkCSMWLfqXFJZDS_t3Pbuqf2oCYxYlj0lBHSFGQohkQ0YKrxWzKyU5D6eO23ILkhGvnfLXAh3XcJVl_-A5MF0FYkVG7USsEFCToO3K7mWhhZw",
                          imageBgColor: AppColor.secondaryColor,
                          rotation: 0.1,
                        ),
                        SizedBox(height: 16.h),
                        const ActionCard(
                          title: AppStrings.projectArchive,
                          description: '',
                          linkText: '',
                          imageUrl:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuBKnn3Q6XJPASL5wjhNgofVeVE5lT_D2146imj-3Lwx857l_Lux0Ik-Zj4iZIL1SOgGlaEYwLbECbgZVIWD5sppfhVp8dIBXBrCUixowQIYUk28J0suLTCIRwS9Yozi7kMOxMGNPqPUokHesqsiXcjmcROlJg143BtOnzBLpmlJNbN1BCO0nTE9LnxMzNfU4OzRDYUCtTyzq62soip4iKhQsb8TsR_1m8hEnmSKw0Ov0oleDTVCNSzoIT34kna4O_Ixfq7AhQC-fDg",
                          imageBgColor: AppColor.primaryContainer,
                          rotation: -0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120.h,
      padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.7),
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuDOx_tAaZy1pE1D1yXLtnUgdMc9ukJUTKi0FbCGhHQ0r-Jg4ZrORsiDlu_5pJlLD55gltl621loWTXaQkWKihucwY0ULzHNmkuy7Qlu5IaCZvCuRtDwnyEnB22Wf-GKWR9WAVth7UD4x-6A_gShwF7rC7zFSYxiAfJhy97ZeAbYWHFjeOHxoYwhsMrjGWsyetisLKQqH1r_miyd5FAPB79SCFHXy7HmJm4Wl8Kknd17e2tSlCtGm3IZluD_1prab8il6tm0VDO3Hc4",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('مرحبا,المسئول', style: AppTextStyle.bold(16)),
                  Text('نظرة عامة للنظام', style: AppTextStyle.medium(16)),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: AppColor.textSecondary,
                  size: 24.sp,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMainStatCard() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(32.w),
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(32.r),
      boxShadow: [
        BoxShadow(
          color: AppColor.accentBlue.withValues(alpha: 0.20),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(color: Colors.grey.shade50),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Opacity(
            opacity: 0.1,
            child: Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuCEiU6ntMl5Vxsjf8NUK6IOAncOT-3xW3utFKNmPOI__qLqVdJy6nTmEjg78lQL9lLtP57SzhpEEaJcOcegPw2SEpij2_DpuJMz4Fcr1BvgcjHoOnmyMmfHHvPBhtEYqB00mHQAcciEDZ4zap9AcQycvEgaEzWNlmnkCSMWLfqXFJZDS_t3Pbuqf2oCYxYlj0lBHSFGQohkQ0YKrxWzKyU5D6eO23ILkhGvnfLXAh3XcJVl_-A5MF0FYkVG7USsEFCToO3K7mWhhZw",
              width: 100.w,
              height: 100.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Column(
          children: [
            Text(AppStrings.totalUsers, style: AppTextStyle.bold(18)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text("1,240", style: AppTextStyle.headline32BoldStyle),
                SizedBox(width: 8.w),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: AppColor.primaryColor,
                      size: 16.sp,
                    ),
                    Text("12%", style: AppTextStyle.bold(19)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // // Simple wavy line simulation
            // SizedBox(
            //   height: 48.h,
            //   width: double.infinity,
            //   child: CustomPaint(painter: WavyLinePainter()),
            // ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, {String? trailing}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: AppTextStyle.bold(18)),
      if (trailing != null)
        Text(
          trailing,
          style: AppTextStyle.bold(16, color: AppColor.primaryColor),
        ),
    ],
  );
}
