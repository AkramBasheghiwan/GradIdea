import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

import 'package:graduation_management_idea_system/feature/user/presentation/view/widgets/build_user_card.dart';
import 'package:flutter/material.dart';

class UserViewBody extends StatelessWidget {
  final List<UserEntity> users;

  const UserViewBody({required this.users, super.key});

  @override
  Widget build(BuildContext context) {
    return
    //RefreshIndicator(
    // onRefresh: onRefresh,
    ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(), // تضمن عمل الـ Refresh دائماً

      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        final UserEntity user = users[index];
        return BuildUserCard(index: index, users: user);
        //   return Container(
        //     margin: const EdgeInsets.only(bottom: 12),
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).scaffoldBackgroundColor,
        //       border: Border.all(
        //         color: Colors.blue.withValues(alpha: 0.2),
        //         width: 1.5,
        //       ),
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     child: ListTile(
        //       contentPadding: const EdgeInsets.symmetric(
        //         horizontal: 16,
        //         vertical: 8,
        //       ),
        //       leading: const CircleAvatar(
        //         radius: 25,
        //         backgroundColor: Colors.grey,
        //         child: Icon(
        //           Icons.person,
        //           color: Colors.white,
        //         ), // هنا يمكنك وضع صورة المستخدم إن وجدت
        //       ),
        //       title: Text(
        //         user.name,
        //         style: const TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16,
        //         ),
        //       ),
        //       subtitle: Text(
        //         'ID: ${user.uid}',
        //         style: TextStyle(color: Colors.grey[600], fontSize: 13),
        //       ),
        //       trailing: IconButton(
        //         icon: const Icon(Icons.edit, color: Colors.blue),
        //         onPressed: () {
        //           // استدعاء النافذة السفلية عند الضغط على القلم
        //           showUserActionsBottomSheet(context, user);
        //         },
        //       ),
        //     ),
        //   );
        // },
      },
    );
  }
}
