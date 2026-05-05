import 'package:equatable/equatable.dart';

abstract class ProjectSearchEvent extends Equatable {
  const ProjectSearchEvent();
  @override
  List<Object?> get props => [];
}

// 1. حدث عند الكتابة في مربع البحث (سنطبق عليه Debounce)
class SearchTextChanged extends ProjectSearchEvent {
  final String query;
  const SearchTextChanged(this.query);
  @override
  List<Object?> get props => [query];
}

// 2. حدث عند تطبيق فلاتر من الـ Bottom Sheet أو حذف فلتر (سيعمل فوراً)
class SearchFiltersApplied extends ProjectSearchEvent {
  final String? department;
  final String? year;
  const SearchFiltersApplied({this.department, this.year});
  @override
  List<Object?> get props => [department, year];
}

// 3. حدث عند التمرير لجلب الصفحة التالية
class FetchNextProjectPage extends ProjectSearchEvent {}
