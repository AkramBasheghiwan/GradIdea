import 'package:flutter/material.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/views/widgets/ai_validation_build_resualt_card.dart';
import 'package:iconsax/iconsax.dart';

class InnovativeIdeaCard extends StatelessWidget {
  const InnovativeIdeaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResultCard(
      color: Colors.green,
      icon: Iconsax.tick_circle,
      title: 'فكرة مبتكرة',
      value: '✓',
      description:
          'لم يتم العثور على مشاريع مشابهة بشكل مؤثر. يمكنك متابعة تطوير هذه الفكرة.',
    );
  }
}
