import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/utils/app_colors.dart';
import 'package:graduation_management_idea_system/core/utils/app_text_style.dart';
import 'package:iconsax/iconsax.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('سياسة الخصوصية', style: AppTextStyle.bold(22)),
        elevation: 0,
        backgroundColor: AppColor.background,
        surfaceTintColor: AppColor.transparent,
        centerTitle: true,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'جمع البيانات',
              content:
                  'تقوم المنصة بجمع البيانات الأساسية اللازمة لإدارة حسابات المستخدمين ومشاريع التخرج، مثل الاسم والبريد الإلكتروني والكلية.',
            ),

            _buildSection(
              title: 'استخدام البيانات',
              content:
                  'تُستخدم البيانات لتحسين تجربة المستخدم، وإدارة أفكار المشاريع، والتحقق من صلاحيات المستخدمين داخل النظام.',
            ),

            _buildSection(
              title: 'مشاركة البيانات',
              content:
                  'لا تتم مشاركة البيانات الشخصية مع أي جهة خارجية إلا عند وجود متطلبات قانونية أو موافقة صريحة من المستخدم.',
            ),

            _buildSection(
              title: 'حماية البيانات',
              content:
                  'تلتزم المنصة باتخاذ الإجراءات المناسبة لحماية بيانات المستخدمين من الوصول غير المصرح به أو الاستخدام غير المشروع.',
            ),

            _buildSection(
              title: 'حقوق المستخدم',
              content:
                  'يحق للمستخدم طلب تحديث بياناته  وفقاً للسياسات المعتمدة من الجهة المشرفة على النظام.',
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'آخر تحديث: يونيو 2026',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.primaryColor.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Iconsax.shield_tick,
                  color: AppColor.primaryColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(child: Text(title, style: AppTextStyle.bold(17))),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            content,
            style: AppTextStyle.medium(14, color: AppColor.textSecondary),
          ),
        ],
      ),
    );
  }
}
