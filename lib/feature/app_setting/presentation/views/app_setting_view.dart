import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_management_idea_system/feature/app_setting/presentation/manager/setting_cubit/cubit/setting_cubit.dart';
import 'package:graduation_management_idea_system/feature/app_setting/presentation/manager/setting_cubit/cubit/setting_state.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';

class AppSettingView extends StatefulWidget {
  const AppSettingView({super.key});

  @override
  State<AppSettingView> createState() => _AppSettingViewState();
}

class _AppSettingViewState extends State<AppSettingView> {
  @override
  void initState() {
    super.initState();
    context.read<AppSettingCubit>().getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("App Settings", style: AppTextStyle.bold(22)),
      ),
      body: BlocConsumer<AppSettingCubit, AppSettingState>(
        listener: (context, state) {
          if (state is AppSettingError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AppSettingLoading || state is AppSettingInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AppSettingLoaded || state is AppSettingUpdating) {
            final setting = state is AppSettingLoaded
                ? state.setting
                : (state as AppSettingUpdating).setting;

            final isUpdating = state is AppSettingUpdating;

            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<AppSettingCubit>().getSetting();
                  },
                  child: ListView(
                    padding: EdgeInsets.all(20.w),
                    children: [
                      _HeaderCard(setting.maxGroup),

                      SizedBox(height: 20.h),

                      Text("Permissions", style: AppTextStyle.bold(18)),

                      SizedBox(height: 14.h),

                      _SettingTile(
                        title: "Upload Projects",
                        subtitle: "Allow students to upload final projects",
                        icon: Icons.cloud_upload_outlined,
                        value: setting.canUploadProjects,
                        onChanged: (value) {
                          context.read<AppSettingCubit>().update(
                            canUploadProjects: value,
                          );
                        },
                      ),

                      SizedBox(height: 14.h),

                      _SettingTile(
                        title: "Upload Proposal",
                        subtitle: "Allow students to upload proposals",
                        icon: Icons.description_outlined,
                        value: setting.canUploadProposal,
                        onChanged: (value) {
                          context.read<AppSettingCubit>().update(
                            canUploadProposal: value,
                          );
                        },
                      ),

                      SizedBox(height: 30.h),

                      Text("Danger Zone", style: AppTextStyle.bold(18)),

                      SizedBox(height: 14.h),

                      _DangerZoneCard(),
                    ],
                  ),
                ),

                if (isUpdating)
                  Container(
                    color: Colors.black12,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final int maxGroup;

  const _HeaderCard(this.maxGroup);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff4F46E5), Color(0xff7C3AED)],
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 10),
            color: Colors.deepPurple.withValues(alpha: 0.25),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.groups_rounded, color: Colors.white, size: 30.sp),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Supervisor Capacity", style: AppTextStyle.bold(16)),
                SizedBox(height: 8.h),
                Text(
                  "$maxGroup Groups",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.sp,
                  ),
                ),
              ],
            ),
          ),

          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.primaryColor,
            ),
            onPressed: () {
              _showEditDialog(context, maxGroup);
            },
            child: const Text("Edit"),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, int current) {
    final controller = TextEditingController(text: current.toString());

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
          title: const Text("Edit Max Group"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Enter max group"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim());

                if (value == null) return;

                context.read<AppSettingCubit>().update(maxGroup: value);

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, color: AppColor.primaryColor),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.bodyMedium),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTextStyle.regular(13, color: Colors.grey),
                ),
              ],
            ),
          ),

          Switch.adaptive(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _DangerZoneCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28.sp),
              SizedBox(width: 8.w),
              Text(
                "Reset Supervisors",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Text(
            "This will clear all supervisors current group counters.",
            style: AppTextStyle.regular(13, color: Colors.grey),
          ),

          SizedBox(height: 18.h),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Confirm Reset"),
                    content: const Text(
                      "Are you sure you want to clear all current groups?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          context.read<AppSettingCubit>().clearCurrentGroups();

                          Navigator.pop(context);
                        },
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text("Clear Current Groups"),
            ),
          ),
        ],
      ),
    );
  }
}
