import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';

class CustomBuildDecisionCard extends StatefulWidget {
  const CustomBuildDecisionCard({
    super.key,
    required this.project,
    required this.onAccept,
    required this.onReject,
  });

  final dynamic project;
  final VoidCallback onAccept;
  final Function(String reason) onReject;

  @override
  State<CustomBuildDecisionCard> createState() =>
      _CustomBuildDecisionCardState();
}

class _CustomBuildDecisionCardState extends State<CustomBuildDecisionCard> {
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

  void _showRejectDialog() {
    _rejectReasonController.clear();

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: const BoxDecoration(
                    color: Color(0xffFEF2F2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: 30.sp,
                  ),
                ),

                SizedBox(height: 18.h),

                Text("رفض المشروع", style: AppTextStyle.bold(20)),

                SizedBox(height: 8.h),

                Text(
                  "اكتب سبب الرفض حتى يتمكن الطلاب من تعديل المشروع",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.medium(13, color: AppColor.grey),
                ),

                SizedBox(height: 20.h),

                TextField(
                  controller: _rejectReasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "اكتب السبب هنا...",
                    filled: true,
                    fillColor: AppColor.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(0, 54.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        child: const Text("إلغاء"),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final reason = _rejectReasonController.text.trim();

                          if (reason.isEmpty) return;

                          Navigator.pop(context);
                          widget.onReject.call(reason);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(0, 54.h),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        child: const Text(
                          "تأكيد",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: widget.onAccept,
                                      icon: const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                      ),
                                      label: const Text(
                                        "قبول المشروع",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        minimumSize: Size(0, 58.h),
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 12.w),

                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _showRejectDialog,
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      label: const Text(
                                        "رفض المقترح",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: Size(0, 58.h),
                                        side: const BorderSide(
                                          color: Colors.red,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

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
