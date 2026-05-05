import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

class ExpandableProjectProposalCard extends StatefulWidget {
  const ExpandableProjectProposalCard({
    super.key,
    required this.project,
    this.onTap,
    this.onEdit,
  });

  final ProjectProposals project;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  @override
  State<ExpandableProjectProposalCard> createState() =>
      _ExpandableProjectProposalCardState();
}

class _ExpandableProjectProposalCardState
    extends State<ExpandableProjectProposalCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return InkWell(
      borderRadius: BorderRadius.circular(26.r),
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: AnimatedContainer(
        duration: 350.ms,
        curve: Curves.easeOutCubic,
        margin: EdgeInsets.only(bottom: 18.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// gradient line
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 6.w,
                decoration: BoxDecoration(
                  gradient: AppColor.primaryGradient,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(26.r),
                    bottomRight: Radius.circular(26.r),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(22.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bold(18),
                        ),
                      ),

                      _StatusBadge(status: project.status ?? "pending"),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  /// description
                  Text(
                    project.description,
                    maxLines: isExpanded ? null : 2,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: AppTextStyle.medium(
                      14,
                      color: AppColor.grey,
                    ).copyWith(height: 1.7),
                  ),

                  SizedBox(height: 18.h),

                  /// stats
                  Row(
                    children: [
                      Expanded(
                        child: _MiniStatCard(
                          icon: Icons.calendar_month_outlined,
                          title: "السنة",
                          value: project.year.toString(),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _MiniStatCard(
                          icon: Icons.school_outlined,
                          title: "القسم",
                          value: project.department,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _MiniStatCard(
                          icon: Icons.groups_2_outlined,
                          title: "الفريق",
                          value: "${project.students.length}",
                        ),
                      ),
                    ],
                  ),

                  /// expanded
                  AnimatedSize(
                    duration: 350.ms,
                    curve: Curves.easeOut,
                    child: isExpanded
                        ? Column(
                            children: [
                              SizedBox(height: 22.h),

                              Divider(
                                color: AppColor.outline.withValues(alpha: .12),
                              ),

                              SizedBox(height: 20.h),

                              /// supervisor
                              _InfoRow(
                                icon: Icons.person_outline,
                                title: "المشرف",
                                value: project.supervisor,
                              ),

                              SizedBox(height: 16.h),

                              /// students
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "أعضاء الفريق",
                                  style: AppTextStyle.bold(14),
                                ),
                              ),

                              SizedBox(height: 12.h),

                              Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: project.students
                                    .map(
                                      (e) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14.w,
                                          vertical: 8.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.secondaryContainer
                                              .withValues(alpha: .25),
                                          borderRadius: BorderRadius.circular(
                                            30.r,
                                          ),
                                        ),
                                        child: Text(
                                          e,
                                          style: AppTextStyle.medium(12),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                              /// reject reason
                              if (project.rejectionReason != null &&
                                  project.rejectionReason!.isNotEmpty) ...[
                                SizedBox(height: 18.h),

                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: .06),
                                    borderRadius: BorderRadius.circular(18.r),
                                    border: Border.all(
                                      color: Colors.red.withValues(alpha: .12),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.info_outline,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          project.rejectionReason!,
                                          style: AppTextStyle.medium(
                                            13,
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              SizedBox(height: 22.h),

                              /// buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: widget.onTap,
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColor.primaryColor,
                                        minimumSize: Size(
                                          double.infinity,
                                          52.h,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "عرض التفاصيل",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  if (widget.onEdit != null) ...[
                                    SizedBox(width: 12.w),
                                    InkWell(
                                      onTap: widget.onEdit,
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: Container(
                                        height: 52.h,
                                        width: 52.h,
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor
                                              .withValues(alpha: .08),
                                          borderRadius: BorderRadius.circular(
                                            14.r,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: AppColor.primaryColor,
                                          size: 22.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),

                  SizedBox(height: 10.h),

                  /// expand button
                  Center(
                    child: AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: 300.ms,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28.sp,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: .15, end: 0);
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case "accepted":
        color = Colors.green;
        text = "معتمد";
        break;

      case "rejected":
        color = Colors.red;
        text = "مرفوض";
        break;

      default:
        color = Colors.orange;
        text = "قيد المراجعة";
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18.sp, color: AppColor.primaryColor),
          SizedBox(height: 6.h),
          Text(title, style: AppTextStyle.medium(11, color: AppColor.grey)),
          SizedBox(height: 4.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bold(12),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: 20.sp),
        SizedBox(width: 10.w),
        Text("$title: ", style: AppTextStyle.bold(14)),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.medium(14, color: AppColor.grey),
          ),
        ),
      ],
    );
  }
}
