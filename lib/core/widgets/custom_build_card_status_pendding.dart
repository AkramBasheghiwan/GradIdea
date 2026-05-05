import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class CustomBuildCardStatusPendding extends StatefulWidget {
  const CustomBuildCardStatusPendding({super.key, required this.project});

  final dynamic project;

  @override
  State<CustomBuildCardStatusPendding> createState() =>
      _CustomBuildCardStatusPenddingState();
}

class _CustomBuildCardStatusPenddingState
    extends State<CustomBuildCardStatusPendding> {
  bool _isExpanded = false;
  final TextEditingController _rejectReasonController = TextEditingController();

  @override
  void dispose() {
    _rejectReasonController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: AppColor.primaryColor, size: 18.sp),
          ),

          SizedBox(width: 12.w),

          Text(title, style: AppTextStyle.bold(14)),

          SizedBox(width: 8.w),

          Expanded(
            child: Text(
              value,
              style: AppTextStyle.medium(13, color: AppColor.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentChip(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.secondaryContainer.withValues(alpha: .22),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        name,
        style: AppTextStyle.medium(12, color: AppColor.primaryColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .05),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(color: AppColor.outline.withValues(alpha: .08)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5.w,
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(28.r),
                  bottomRight: Radius.circular(28.r),
                ),
              ),
            ),
          ),

          InkWell(
            borderRadius: BorderRadius.circular(28.r),
            onTap: _toggle,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.name,
                          style: AppTextStyle.bold(18),
                          maxLines: _isExpanded ? null : 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFF7ED),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 15.sp,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "قيد الانتظار",
                              style: AppTextStyle.bold(
                                11,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Text(
                      widget.project.description,
                      style: AppTextStyle.medium(13, color: AppColor.grey),
                      maxLines: _isExpanded ? null : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: 300.ms,
                    child: !_isExpanded
                        ? Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: TextButton.icon(
                              onPressed: _toggle,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              label: const Text("عرض التفاصيل"),
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(height: 20.h),

                              _buildInfoRow(
                                Icons.person_outline,
                                "المشرف:",
                                widget.project.supervisor,
                              ),

                              _buildInfoRow(
                                Icons.calendar_month,
                                "سنة التخرج:",
                                widget.project.year.toString(),
                              ),

                              if (widget.project.fileUrl != null &&
                                  widget.project.fileUrl!.isNotEmpty)
                                _buildInfoRow(
                                  Icons.attach_file,
                                  "الملف:",
                                  "عرض الملف",
                                ),

                              SizedBox(height: 8.h),

                              Text(
                                "الطلاب المشاركين",
                                style: AppTextStyle.bold(14),
                              ),

                              SizedBox(height: 12.h),

                              Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: widget.project.students
                                    .map(_buildStudentChip)
                                    .toList(),
                              ),

                              SizedBox(height: 22.h),

                              Center(
                                child: TextButton(
                                  onPressed: _toggle,
                                  child: const Text("طي التفاصيل"),
                                ),
                              ),
                            ],
                          ).animate().fade().slideY(begin: .1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
