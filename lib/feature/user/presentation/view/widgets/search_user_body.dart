import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// مسارات ملفاتك (تأكد منها)
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/search_user_bloc/search_bloc.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/search_user_bloc/search_state_event.dart';

// استيراد بطاقة المستخدم الاحترافية التي صممناها سابقاً
import 'package:graduation_management_idea_system/feature/user/presentation/view/widgets/build_user_card.dart';

class SearchUserViewBody extends StatefulWidget {
  const SearchUserViewBody({super.key});

  @override
  State<SearchUserViewBody> createState() => _SearchUserViewBodyState();
}

class _SearchUserViewBodyState extends State<SearchUserViewBody> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce; // لتأخير البحث أثناء الكتابة للحفاظ على أداء السيرفر

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // استدعاء أولي لجلب البيانات عند فتح الشاشة (اختياري)
    // context.read<SearchBloc>().add(FetchInitialData());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // طلب الصفحة التالية عند الوصول لـ 90% من التمرير
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<SearchBloc>().add(FetchNextPage());
    }
  }

  // دالة البحث مع تأخير (Debounce)
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // قم بتغيير اسم الحدث (Event) حسب الموجود لديك في ملف search_state_event.dart
      // context.read<SearchBloc>().add(SearchQueryChanged(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background, // لون خلفية هادئ
      body: SafeArea(
        child: Column(
          children: [
            // ==========================================
            // 1. شريط البحث المبتكر (Floating Search Bar)
            // ==========================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child:
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      style: AppTextStyle.bodyLarge16NormalStyle,
                      decoration: InputDecoration(
                        hintText: 'ابحث عن مستخدم، إيميل، أو دور...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.primaryColor,
                          size: 24.sp,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.grey.shade400,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _onSearchChanged(''); // تحديث البحث بعد المسح
                                  setState(() {}); // لتحديث أيقونة الـ clear
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                    ),
                  ).animate().fadeIn().slideY(
                    begin: -0.2,
                    end: 0,
                    duration: 500.ms,
                  ),
            ),

            // ==========================================
            // 2. عرض نتائج البحث مع التعامل مع الحالات
            // ==========================================
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  // -- حالة التحميل (Loading) --
                  // افترض أن لديك حالة اسمها SearchLoading
                  // if (state is SearchLoading) {
                  //   return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
                  // }

                  // -- حالة نجاح جلب البيانات (Loaded) --
                  if (state is SearchLoaded) {
                    final users = state.users;
                    final hasReachedMax = state.hasReachedMax;

                    // إذا كانت القائمة فارغة (لا توجد نتائج)
                    if (users.isEmpty) {
                      return _buildEmptyState();
                    }

                    // عرض قائمة المستخدمين
                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      physics:
                          const BouncingScrollPhysics(), // تأثير تمرير ناعم
                      itemCount: hasReachedMax
                          ? users.length
                          : users.length + 1,
                      itemBuilder: (context, index) {
                        // عرض مؤشر التحميل في نهاية القائمة (Pagination Loader)
                        if (index >= users.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 3),
                            ),
                          );
                        }

                        // عرض بطاقة المستخدم الاحترافية
                        final user = users[index];
                        return BuildUserCard(users: user, index: index);
                      },
                    );
                  }

                  // -- حالة الخطأ (Error) --
                  // if (state is SearchError) {
                  //   return _buildErrorState(state.message);
                  // }

                  // -- الحالة الافتراضية (قبل البحث) --
                  return _buildInitialState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // أدوات مساعدة للحالات الفارغة والافتراضية
  // ==========================================

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search_rounded,
            size: 80.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            "ابدأ بكتابة اسم المستخدم للبحث...",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 16.sp),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 80.sp,
                color: AppColor.secondaryColor.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                "لا توجد نتائج مطابقة لبحثك",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "تأكد من كتابة الاسم أو البريد بشكل صحيح",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
              ),
            ],
          ).animate().fadeIn().scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
          ),
    );
  }
}
