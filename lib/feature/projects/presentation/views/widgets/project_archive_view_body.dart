import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/project_archieve_cubit/projects_archieve_state.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/project_archieve_cubit/projects_archive.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_build_card_projects_approved.dart';

class ProjectsArchiveScreen extends StatefulWidget {
  const ProjectsArchiveScreen({super.key});

  @override
  State<ProjectsArchiveScreen> createState() => _ProjectsArchiveScreenState();
}

class _ProjectsArchiveScreenState extends State<ProjectsArchiveScreen> {
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
    return RefreshIndicator(
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
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
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
              itemCount: hasReachedMax ? projects.length : projects.length + 1,
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
                return CustomBuildCardProjectsApproved(
                  project: project,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.projectDetail,
                    arguments: project,
                  ),
                );
              },
            );
          }

          // الحالة الابتدائية الصامتة
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
