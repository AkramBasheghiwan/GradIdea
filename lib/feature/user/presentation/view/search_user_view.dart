import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/search_user_bloc/search_bloc.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/view/widgets/search_user_body.dart';

class SearchUserView extends StatelessWidget {
  const SearchUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: const SearchPage(),
    );
  }
}
