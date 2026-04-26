import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/project_archieve_cubit/projects_archieve_state.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/project_archieve_cubit/projects_archive.dart';

class ProjectsArchiveScreen extends StatefulWidget {
  // رقم القسم الذي نريد عرض أبحاثه

  const ProjectsArchiveScreen({super.key});

  @override
  State<ProjectsArchiveScreen> createState() => _ProjectsArchiveScreenState();
}

class _ProjectsArchiveScreenState extends State<ProjectsArchiveScreen> {
  // 1. متحكم التمرير (ScrollController) السحري 🪄
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<ProjectsArchiveCubit>().fetchFirstPage();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= 200) {
      context.read<ProjectsArchiveCubit>().fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أرشيف المشاريع المعتمدة')),

      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ProjectsArchiveCubit>().fetchFirstPage();
        },
        child: BlocBuilder<ProjectsArchiveCubit, ProjectsArchieveState>(
          builder: (context, state) {
            if (state is ProjectArchieveLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectArchieveError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ProjectsArchiveCubit>().fetchFirstPage(),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }
            // ج. حالة نجاح جلب البيانات (الصفحة الأولى أو أي صفحة بعدها)
            else if (state is ProjectArchieveLoaded) {
              final projects = state.users;
              final hasReachedMax = state.hasReachedMax;

              if (projects.isEmpty) {
                return const Center(
                  child: Text(
                    'لا توجد مشاريع معتمدة في هذا القسم بعد 📚',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              // رسم القائمة اللانهائية
              return ListView.builder(
                controller: _scrollController,

                itemCount: hasReachedMax
                    ? projects.length
                    : projects.length + 1,
                itemBuilder: (context, index) {
                  if (index >= projects.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  }

                  final project = projects[index];
                  return _buildProjectCard(context, project);
                },
              );
            }

            // الحالة الابتدائية الصامتة
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectEntity project) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // فتح شاشة تفاصيل المشروع
          // Navigator.pushNamed(context, '/project_details', arguments: project);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'إشراف: ${project.supervisor}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.group, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  // عرض عدد الطلاب المكتوبين في المصفوفة
                  Text(
                    'الطلاب: ${project.students.length} طالب/ـة',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              const Divider(height: 24),
              Text(
                project.description,
                maxLines: 3, // عرض نبذة فقط
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54, height: 1.4),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'عام ${project.year}',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
