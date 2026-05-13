import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/fetch_supersior_cubit/cubit/fetch_supersior_cubit.dart';
import 'package:iconsax/iconsax.dart';

Future<Map<String, String>?> showSupervisorBottomSheet(
  BuildContext context,
) async {
  if (!context.mounted) return null;

  return await showModalBottomSheet<Map<String, String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (_) => sl<FetchSupersiorCubit>()..fetchAvailableSupersior(),
      child: const _SupervisorBottomSheetContent(),
    ),
  );
}

class _SupervisorBottomSheetContent extends StatefulWidget {
  const _SupervisorBottomSheetContent();

  @override
  State<_SupervisorBottomSheetContent> createState() =>
      _SupervisorBottomSheetContentState();
}

class _SupervisorBottomSheetContentState
    extends State<_SupervisorBottomSheetContent> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSupersiorCubit, FetchSupersiorState>(
      builder: (context, state) {
        /// Loading
        if (state is FetchSupersiorLoading) {
          return Container(
            height: MediaQuery.of(context).size.height * .45,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        /// Error
        if (state is FetchSuperiorError) {
          return Container(
            height: MediaQuery.of(context).size.height * .45,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
            ),
            child: Center(
              child: Text(
                'حدث خطأ أثناء تحميل المشرفين',
                style: AppTextStyle.bold(15),
              ),
            ),
          );
        }

        /// Loaded
        if (state is FetchSupersiorLoaded) {
          final filtered = state.supervsiorAvailable.where((supervisor) {
            return supervisor.name.toLowerCase().contains(search.toLowerCase());
          }).toList();

          return Container(
            height: MediaQuery.of(context).size.height * 0.82,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 14),

                Container(
                  width: 46,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),

                const SizedBox(height: 20),

                /// Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.withValues(alpha: .12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.teacher,
                          color: AppColor.primaryColor,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("اختيار المشرف", style: AppTextStyle.bold(18)),
                            const SizedBox(height: 4),
                            Text(
                              "اختر المشرف المناسب لمشروعك",
                              style: AppTextStyle.medium(
                                12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.withValues(alpha: .08),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "${filtered.length}",
                          style: AppTextStyle.bold(
                            13,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                /// Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onChanged: (value) => setState(() => search = value),
                    decoration: InputDecoration(
                      hintText: "ابحث عن مشرف...",
                      prefixIcon: const Icon(Iconsax.search_normal_1),
                      filled: true,
                      fillColor: const Color(0xffF7F8FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            "لا يوجد نتائج",
                            style: AppTextStyle.bold(15, color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, index) {
                            final supervisor = filtered[index];

                            return InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {
                                Navigator.pop(context, {
                                  'id': supervisor.id,
                                  'name': supervisor.name,
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: .04,
                                      ),
                                      blurRadius: 18,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 58,
                                      height: 58,
                                      decoration: const BoxDecoration(
                                        gradient: AppColor.primaryGradient,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Iconsax.teacher,
                                        color: Colors.white,
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            supervisor.name,
                                            style: AppTextStyle.bold(15),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "المجموعات الحالية: ${supervisor.currentGroups} / ${supervisor.maxGroups}",
                                            style: AppTextStyle.medium(
                                              12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withValues(
                                          alpha: .12,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        "${supervisor.remain} متاح",
                                        style: AppTextStyle.bold(
                                          12,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
