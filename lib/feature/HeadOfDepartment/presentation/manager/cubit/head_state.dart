// import 'package:equatable/equatable.dart';
// import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';


// abstract class HeadOfDepartmentState extends Equatable {
//   const HeadOfDepartmentState();

//   @override
//   List<Object?> get props => [];
// }


// class HeadOfDepartmentInitial extends HeadOfDepartmentState {}


// class HeadOfDepartmentLoading extends HeadOfDepartmentState {}

// class HeadOfDepartmentLoaded extends HeadOfDepartmentState {
//   final List<ProjectEntity> projects;

//   const HeadOfDepartmentLoaded(this.projects);
// // 
//   @override
//   List<Object?> get props => [projects];
// }


// class HeadOfDepartmentError extends HeadOfDepartmentState {
//   final String message;

//   const HeadOfDepartmentError(this.message);

//   @override
//   List<Object?> get props => [message];
// }


// class HeadOfDepartmentProjectUpdating extends HeadOfDepartmentState {
//     final String projectId;
//     const HeadOfDepartmentProjectUpdating(this.projectId);

//     @override
//     List<Object?> get props => [projectId];
// }

// // حالة لإعلام الواجهة بنجاح عملية التحديث (تستخدم مع BlocListener لعرض Snackbar)
// class HeadOfDepartmentUpdateSuccess extends HeadOfDepartmentState {
//     final String successMessage;
//     const HeadOfDepartmentUpdateSuccess(this.successMessage);

//      @override
//     List<Object?> get props => [successMessage];
// }
