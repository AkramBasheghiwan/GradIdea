import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/ai_validation_build_resualt_card.dart';
import 'package:iconsax/iconsax.dart';

class SimilarIdeaCard extends StatelessWidget {
  const SimilarIdeaCard({super.key, required this.similarity});

  final double similarity;

  @override
  Widget build(BuildContext context) {
    return ResultCard(
      color: Colors.orange,
      icon: Iconsax.warning_2,
      title: 'تشابه مرتفع',
      value: '${similarity.toStringAsFixed(1)}%',
      description:
          'هناك مشاريع قريبة من فكرتك. حاول إضافة ميزات جديدة أو تغيير زاوية الحل.',
    );
  }
}
