import 'package:graduation_management_idea_system/feature/user/presentation/manager/cubit/cubit.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/cubit/state.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/view/widgets/user_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListViewBlocBuilder extends StatelessWidget {
  const UsersListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (BuildContext context, UsersState state) {
        if (state is UsersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UsersError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is UsersLoaded) {
          if (state.users.isEmpty) {
            return const Center(child: Text('لا يوجد مستخدمين.'));
          }
          return UserViewBody(users: state.users);
        }
        return const Center(child: Text('لا يوجد مستخدمين.'));
      },
    );
  }
}
