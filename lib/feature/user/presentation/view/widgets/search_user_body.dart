import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_project_card_skeleton.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/search_user_bloc/search_bloc.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/search_user_bloc/search_state_event.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/view/widgets/build_user_card.dart';

class SearchUserViewBody extends StatefulWidget {
  const SearchUserViewBody({super.key});

  @override
  _SearchUserViewBodyState createState() => _SearchUserViewBodyState();
}

class _SearchUserViewBodyState extends State<SearchUserViewBody> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= (maxScroll * 0.9) &&
        _searchBloc.state is SearchLoaded) {
      final currentState = _searchBloc.state as SearchLoaded;
      _searchBloc.add(FetchNextPage(currentState.currentQuery));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('بحث عن المستخدمين', style: AppTextStyle.bold(18)),
        backgroundColor: AppColor.activeBgColor,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _textController,
      autofocus: true,
      onChanged: (query) => _searchBloc.add(SearchQueryChanged(query: query)),
      decoration: InputDecoration(
        hintText: 'ابحث بالاسم أو البريد (اكتب "error" للخطأ)',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.grey),
          onPressed: () {
            _textController.clear();
            _searchBloc.add(ClearSearch());
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildResults() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'ابحث عن مستخدمين في النظام',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        if (state is SearchLoading) {
          return ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) => const ProjectCardSkeleton(),
          );
        }
        if (state is SearchError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 80,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        if (state is SearchLoaded) {
          if (state.users.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد نتائج لهذا البحث.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.users.length
                : state.users.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.users.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return BuildUserCard(index: index, users: state.users[index]);
            },
          );
        }
        return Container(); // حالة غير متوقعة
      },
    );
  }
}
