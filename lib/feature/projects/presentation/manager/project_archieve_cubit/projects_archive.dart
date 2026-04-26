import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/projects_repository.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/project_archieve_cubit/projects_archieve_state.dart';
// ... استيرادات الـ States والـ Entity والـ Repo

class ProjectsArchiveCubit extends Cubit<ProjectsArchieveState> {
  final ProjectsRepository repository;
  final String departmentId;

  List<ProjectEntity> _currentProjects = [];
  int _currentPage = 0;
  bool _hasReachedMax = false;
  bool _isFetchingMore = false;

  ProjectsArchiveCubit(this.repository, this.departmentId)
    : super(ProjectArchieveInitial());

  // 1. جلب الصفحة الأولى (عند فتح الشاشة أو السحب للتحديث Pull-to-refresh)
  Future<void> fetchFirstPage() async {
    emit(ProjectArchieveLoading()); // دائرة تحميل في منتصف الشاشة

    _currentPage = 0;
    _currentProjects = [];
    _hasReachedMax = false;

    final result = await repository.fetchAllProjects(
      departmentId,
      _currentPage,
    );

    result.fold(
      (failure) => emit(ProjectArchieveError(message: failure.message)),
      (projects) {
        _currentProjects = projects;
        _hasReachedMax = projects.length < 10; // إذا رجع أقل من 10، يعني خلصوا
        emit(
          ProjectArchieveLoaded(
            users: _currentProjects,
            hasReachedMax: _hasReachedMax,
            page: _currentPage,
          ),
        );
      },
    );
  }

  // 2. جلب الصفحة التالية (عند التمرير لنهاية القائمة)
  Future<void> fetchNextPage() async {
    if (_isFetchingMore || _hasReachedMax) return;

    _isFetchingMore = true;
    _currentPage++;

    final result = await repository.fetchAllProjects(
      departmentId,
      AppProjectsStatus._currentPage,
    );

    result.fold(
      (failure) {
        _currentPage--;
        _isFetchingMore = false;
        // هنا يمكن إطلاق حالة خطأ خاصة بالـ Pagination دون مسح القائمة الحالية
      },
      (moreProjects) {
        _currentProjects.addAll(
          moreProjects,
        ); // دمج المشاريع الجديدة مع القديمة
        _hasReachedMax = moreProjects.length < 10;
        _isFetchingMore = false;

        // إطلاق القائمة المدمجة الجديدة
        emit(
          ProjectArchieveLoaded(
            users: List.from(_currentProjects),
            hasReachedMax: _hasReachedMax,
            page: _currentPage,
          ),
        );
      },
    );
  }
}
