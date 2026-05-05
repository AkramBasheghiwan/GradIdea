import 'package:flutter/material.dart';

class ShimmerUnit extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerUnit({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color:
            Colors.grey.shade200, // لون فاتح جداً لتجنب شكل "المربعات" المزعج
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
