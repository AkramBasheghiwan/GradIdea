import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/core/widgets/custom_shimmer.dart';
import 'package:graduation_management_idea_system/core/widgets/shimmer_loading_widget.dart';

class ProjectCardSkeleton extends StatelessWidget {
  const ProjectCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey.shade100), // حدود خفيفة جداً
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // مكان الأيقونة الدائري
                ShimmerUnit(height: 48, width: 48, borderRadius: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // سطر العنوان (طويل)
                      ShimmerUnit(height: 14, width: double.infinity),
                      SizedBox(height: 10),
                      // سطر القسم (قصير)
                      ShimmerUnit(height: 12, width: 60),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            // أسطر الوصف (متفاوتة الأطوال لتبدو طبيعية)
            ShimmerUnit(height: 10, width: double.infinity),
            SizedBox(height: 10),
            ShimmerUnit(height: 10, width: double.infinity),
            SizedBox(height: 10),
            ShimmerUnit(height: 10, width: 140), // سطر أخير قصير
          ],
        ),
      ),
    );
  }
}
