import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/domain/repository/proposal_approved_repository.dart';

import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_approved/proposal_approved_state.dart';

class ProposalApprovedCubit extends Cubit<ProposalApprovedState> {
  final ProposalApprovedRepository repository;
  final String departmentId;

  List<ProjectProposals> _currentProjects = [];
  int _currentPage = 0;
  bool _hasReachedMax = false;
  bool _isFetchingMore = false;

  ProposalApprovedCubit(this.repository, this.departmentId)
    : super(ProposalApprovedInitial());

  Future<void> fetchFirstPage() async {
    emit(ProposalApprovedLoading()); // دائرة تحميل في منتصف الشاشة

    final result = await repository.fetchAllProposals(
      departmentId: departmentId,
      page: _currentPage,
      status: AppProjectsStatus.approved,
    );

    result.fold(
      (failure) => emit(ProposalApprovedError(message: failure.message)),
      (projects) {
        _currentProjects = projects;
        _hasReachedMax = projects.length < 10;
        emit(
          ProposalApprovedLoaded(
            users: _currentProjects,
            hasReachedMax: _hasReachedMax,
            page: _currentPage,
          ),
        );
      },
    );
  }

  // في ملف upload_project_cubit.dart

  // 2. جلب الصفحة التالية (عند التمرير لنهاية القائمة)
  Future<void> fetchNextPage() async {
    if (_isFetchingMore || _hasReachedMax) return;

    _isFetchingMore = true;
    _currentPage++;

    final result = await repository.fetchAllProposals(
      departmentId: departmentId,
      page: _currentPage,
      status: AppProjectsStatus.approved,
    );

    result.fold(
      (failure) {
        _currentPage--;
        _isFetchingMore = false;
      },
      (moreProjects) {
        _currentProjects.addAll(
          moreProjects,
        ); // دمج المشاريع الجديدة مع القديمة
        _hasReachedMax = moreProjects.length < 10;
        _isFetchingMore = false;

        // إطلاق القائمة المدمجة الجديدة
        emit(
          ProposalApprovedLoaded(
            users: List.from(_currentProjects),
            hasReachedMax: _hasReachedMax,
            page: _currentPage,
          ),
        );
      },
    );
  }
}
