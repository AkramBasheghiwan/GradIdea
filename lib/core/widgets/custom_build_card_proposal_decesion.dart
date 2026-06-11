import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:iconsax/iconsax.dart';

class CustomBuildCardProposalDecesion extends StatefulWidget {
  const CustomBuildCardProposalDecesion({
    super.key,
    required this.proposals,
    required this.onAccept,
    required this.onReject,
  });

  final ProjectProposals proposals;
  final VoidCallback onAccept;
  final Function(String reason) onReject;

  @override
  State<CustomBuildCardProposalDecesion> createState() =>
      _CustomBuildDecisionCardState();
}

class _CustomBuildDecisionCardState
    extends State<CustomBuildCardProposalDecesion> {
  bool _isExpanded = false;
  final TextEditingController _rejectReasonController = TextEditingController();

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  void dispose() {
    _rejectReasonController.dispose();
    super.dispose();
  }

  void _showRejectDialog() {
    _rejectReasonController.clear();

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(26.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔴 Icon
              Container(
                width: 60.w,
                height: 60.w,
                decoration: const BoxDecoration(
                  color: Color(0xffFEF2F2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.close_circle,
                  color: Colors.red,
                  size: 30.sp,
                ),
              ),

              SizedBox(height: 16.h),

              Text("رفض المشروع", style: AppTextStyle.bold(18)),

              SizedBox(height: 8.h),

              Text(
                "اكتب سبب الرفض ليتمكن الطلاب من التعديل",
                textAlign: TextAlign.center,
                style: AppTextStyle.medium(13, color: AppColor.grey),
              ),

              SizedBox(height: 18.h),

              TextField(
                controller: _rejectReasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "اكتب السبب هنا...",
                  filled: true,
                  fillColor: AppColor.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Iconsax.arrow_left_2, size: 16.sp),
                      label: const Text("إلغاء"),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final reason = _rejectReasonController.text.trim();
                        if (reason.isEmpty) return;

                        Navigator.pop(context);
                        widget.onReject(reason);
                      },
                      icon: Icon(Iconsax.tick_circle, size: 16.sp),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      label: const Text("تأكيد"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.user, size: 14.sp, color: AppColor.primaryColor),
          SizedBox(width: 4.w),
          Text(
            text,
            style: AppTextStyle.medium(12, color: AppColor.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColor.primaryColor),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.medium(13, color: AppColor.outline),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.proposals;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .05),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(26.r),
        onTap: _toggle,
        child: Padding(
          padding: EdgeInsets.all(18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔷 Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      p.name,
                      style: AppTextStyle.bold(17).copyWith(height: 1.4),
                      maxLines: _isExpanded ? null : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFF7ED),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.timer_1,
                          size: 14.sp,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "قيد الانتظار",
                          style: AppTextStyle.bold(11, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              /// 📝 Description
              Text(
                p.description,
                maxLines: _isExpanded ? null : 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.medium(13, color: AppColor.grey),
              ),

              SizedBox(height: 14.h),

              /// 👨‍🏫 Supervisor + Year
              _info(Iconsax.teacher, p.supervisor),
              SizedBox(height: 6.h),
              _info(Iconsax.calendar_1, "دفعة ${p.year}"),

              AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _toggle,
                    icon: Icon(Iconsax.arrow_down_1, size: 16.sp),
                    label: const Text("عرض التفاصيل"),
                  ),
                ),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.h),

                    /// 👥 Students
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: p.students.map(_chip).toList(),
                    ),

                    SizedBox(height: 18.h),

                    /// ✅ Actions
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onAccept,
                            icon: Icon(
                              Iconsax.tick_circle,
                              size: 18.sp,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            label: const Text("قبول"),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _showRejectDialog,
                            icon: Icon(
                              Iconsax.close_circle,
                              size: 18.sp,
                              color: Colors.red,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                            label: const Text(
                              "رفض",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Center(
                      child: TextButton.icon(
                        onPressed: _toggle,
                        icon: Icon(Iconsax.arrow_up_2, size: 16.sp),
                        label: const Text("إخفاء"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
