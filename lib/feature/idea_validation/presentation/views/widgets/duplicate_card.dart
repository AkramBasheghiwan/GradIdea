import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/ai_validation_build_resualt_card.dart';
import 'package:iconsax/iconsax.dart';

class DuplicateIdeaCard extends StatelessWidget {
  const DuplicateIdeaCard({super.key, required this.similarity});

  final double similarity;

  @override
  Widget build(BuildContext context) {
    return ResultCard(
      color: Colors.red,
      icon: Iconsax.close_circle,
      title: 'فكرة مكررة',
      value: '${similarity.toStringAsFixed(1)}%',
      description:
          'الفكرة متطابقة تقريباً مع مشاريع موجودة. يوصى بإعادة صياغتها أو اختيار فكرة أخرى.',
    );
  }
}
