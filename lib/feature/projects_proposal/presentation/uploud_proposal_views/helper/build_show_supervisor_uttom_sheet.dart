import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<Map<String, String>?> showSupervisorBottomSheet(
  BuildContext context,
) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase.from('supervisor_detail').select('''
          supervisor_id,
          max_groups,
          current_groups,
          users!supervisor_id(
            id,
            name
          )
        ''');

    final available = (response as List)
        .where((e) => e['current_groups'] < e['max_groups'])
        .toList();

    if (!context.mounted) return null;

    return await showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SizedBox(
          height: 500,
          child: Column(
            children: [
              const SizedBox(height: 16),

              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),

              const SizedBox(height: 20),

              Text("اختر المشرف", style: AppTextStyle.bold(18)),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: available.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, index) {
                    final item = available[index];
                    final user = item['users'];

                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      tileColor: Colors.grey.shade50,
                      leading: CircleAvatar(
                        backgroundColor: AppColor.primaryColor.withValues(
                          alpha: .1,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      title: Text(
                        user['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "المجموعات: ${item['current_groups']} / ${item['max_groups']}",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Navigator.pop(context, {
                          'id': item['supervisor_id'].toString(),
                          'name': user['name'].toString(),
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
