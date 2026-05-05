import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

// ==========================================
// 1. الأحداث (Events)
// ==========================================
abstract class SearchEvent {}

// حدث عند كتابة نص جديد في مربع البحث (يمسح القديم ويبدأ من صفحة 0)
class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged({required this.query});
}

class FetchNextPage extends SearchEvent {
  final String query;
  FetchNextPage(this.query);
}

class ClearSearch extends SearchEvent {}

// ==========================================
// 2. الحالات (States)
// ==========================================
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

// حالة عرض البيانات
class SearchLoaded extends SearchState {
  final List<UserEntity> users;
  final bool hasReachedMax; // هل وصلنا لنهاية البيانات في السيرفر؟
  final int currentPage; // لمعرفة الصفحة الحالية
  final String currentQuery; // للاحتفاظ بكلمة البحث الحالية

  SearchLoaded({
    required this.users,
    required this.hasReachedMax,
    required this.currentPage,
    required this.currentQuery,
  });

  // دالة مساعدة لنسخ الحالة وتحديث جزء منها
  SearchLoaded copyWith({
    List<UserEntity>? users,
    bool? hasReachedMax,
    int? currentPage,
    String? currentQuery,
  }) {
    return SearchLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      currentQuery: currentQuery ?? this.currentQuery,
    );
  }
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
