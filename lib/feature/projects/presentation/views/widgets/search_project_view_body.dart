import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_project_card_skeleton.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/search_projects_cubit/search_projects_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/search_projects_cubit/search_projects_event.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/search_projects_cubit/search_projects_status.dart';

class ProjectSearchPageBody extends StatefulWidget {
  const ProjectSearchPageBody({super.key});

  @override
  State<ProjectSearchPageBody> createState() => _ProjectSearchPageBodyState();
}

class _ProjectSearchPageBodyState extends State<ProjectSearchPageBody> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  late ProjectSearchBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ProjectSearchBloc>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= (maxScroll * 0.9)) {
      if (_bloc.state is ProjectSearchLoaded) {
        _bloc.add(FetchNextProjectPage());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'مشاريع التخرج',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColor.primaryColor, // استخدام اللون الرئيسي
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. شريط البحث والفلتر
            _buildSearchBarAndFilter(),

            // 2. الفلاتر النشطة (تظهر فقط إذا كان هناك فلتر مفعل)
            _buildActiveFiltersRow(),

            const SizedBox(height: 16),

            // 3. عرض النتائج مع التمرير اللانهائي
            Expanded(child: _buildResultsList()),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 1. ودجت شريط البحث وأيقونة الفلتر
  // ==========================================
  Widget _buildSearchBarAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _textController,
              onChanged: (val) => _bloc.add(SearchTextChanged(val)),
              decoration: InputDecoration(
                hintText: 'ابحث عن فكرة، اسم مشروع...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColor.primaryColor,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(color: AppColor.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: AppColor.primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // زر الفلتر
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.tune_rounded, color: Colors.white),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 2. ودجت عرض الفلاتر النشطة (Chips)
  // ==========================================
  Widget _buildActiveFiltersRow() {
    return BlocBuilder<ProjectSearchBloc, ProjectSearchState>(
      builder: (context, state) {
        if (state is! ProjectSearchLoaded) return const SizedBox();
        if (state.currentDept == null && state.currentYear == null) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Text(
                'نشط الآن:',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (state.currentDept != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(
                              state.currentDept!,
                              style: const TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: AppColor.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            deleteIconColor: AppColor.primaryColor,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onDeleted: () => _bloc.add(
                              SearchFiltersApplied(
                                department: null,
                                year: state.currentYear,
                              ),
                            ),
                          ),
                        ),
                      if (state.currentYear != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(
                              'سنة ${state.currentYear}',
                              style: const TextStyle(
                                color: AppColor.secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: AppColor.secondaryColor.withValues(
                              alpha: 0.1,
                            ),
                            deleteIconColor: AppColor.secondaryColor,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onDeleted: () => _bloc.add(
                              SearchFiltersApplied(
                                department: state.currentDept,
                                year: null,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================
  // 3. ودجت قائمة النتائج
  // ==========================================
  Widget _buildResultsList() {
    return BlocConsumer<ProjectSearchBloc, ProjectSearchState>(
      listenWhen: (prev, current) =>
          current is ProjectSearchLoaded && current.paginationError != null,
      listener: (context, state) {
        if (state is ProjectSearchLoaded && state.paginationError != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.paginationError!),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is ProjectSearchInitial || state is ProjectSearchLoading) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 6, // عرض 6 بطاقات تحميل
            itemBuilder: (context, index) => const ProjectCardSkeleton(),
          );
        }
        if (state is ProjectSearchError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          );
        }

        if (state is ProjectSearchLoaded) {
          if (state.projects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_off_outlined,
                    size: 64,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد مشاريع تطابق بحثك.',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: state.hasReachedMax
                ? state.projects.length
                : state.projects.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.projects.length) {
                if (state.paginationError != null) return const SizedBox();
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  ),
                );
              }

              return ExpandableProjectCard(project: state.projects[index]);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  // ==========================================
  // 4. ودجت الـ Bottom Sheet للفلترة
  // ==========================================
  void _showFilterBottomSheet() {
    final currentState = _bloc.state;
    String? tempDept;
    String? tempYear;

    if (currentState is ProjectSearchLoaded) {
      tempDept = currentState.currentDept;
      tempYear = currentState.currentYear;
    }

    final List<String> departments = ['IT', 'CS', 'IS'];
    final List<String> years = ['2023', '2024', '2025', '2026', '2027'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                left: 24,
                right: 24,
                top: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // مؤشر السحب (Drag handle)
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Center(
                    child: Text(
                      'تصفية المشاريع',
                      style: AppTextStyle.bold(
                        18,
                      ).copyWith(color: AppColor.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'القسم (التخصص):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: departments
                        .map(
                          (dept) => ChoiceChip(
                            label: Text(dept),
                            labelStyle: TextStyle(
                              color: tempDept == dept
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: tempDept == dept
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            selected: tempDept == dept,
                            selectedColor: AppColor.primaryColor,
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            showCheckmark: false,
                            onSelected: (selected) => setModalState(
                              () => tempDept = selected ? dept : null,
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'سنة التخرج:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: tempYear,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColor.primaryColor,
                        ),
                        hint: Text(
                          'اختر السنة',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        items: years
                            .map(
                              (y) => DropdownMenuItem(
                                value: y,
                                child: Text(
                                  y,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => setModalState(() => tempYear = val),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        _bloc.add(
                          SearchFiltersApplied(
                            department: tempDept,
                            year: tempYear,
                          ),
                        );
                        Navigator.pop(bottomSheetContext);
                      },
                      child: Text(
                        'تطبيق الفلاتر',
                        style: AppTextStyle.bold(
                          16,
                        ).copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// =========================================================================
// 5. ودجت البطاقة القابلة للتوسيع (Expandable Project Card)
// =========================================================================
class ExpandableProjectCard extends StatefulWidget {
  final dynamic project; // ⚠️ يُفضل استبدال dynamic بـ ProjectModel الخاص بك

  const ExpandableProjectCard({super.key, required this.project});

  @override
  State<ExpandableProjectCard> createState() => _ExpandableProjectCardState();
}

class _ExpandableProjectCardState extends State<ExpandableProjectCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان والقسم
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: AppColor.primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project.title ?? 'بدون عنوان',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                            maxLines: _isExpanded ? null : 1,
                            overflow: _isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.secondaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.project.department ?? 'غير محدد',
                              style: const TextStyle(
                                color: AppColor.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // الوصف والتفاصيل الإضافية
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.description ?? 'لا يوجد وصف متاح.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.6,
                          fontSize: 14,
                        ),
                        maxLines: _isExpanded ? null : 2,
                        overflow: _isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),

                      if (_isExpanded) ...[
                        const SizedBox(height: 16),
                        Divider(color: Colors.grey.shade100, thickness: 1.5),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              size: 20,
                              color: AppColor.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'سنة التخرج: ${widget.project.year ?? '-'}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // زر عرض المزيد / أقل
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => setState(() => _isExpanded = !_isExpanded),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColor.secondaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
