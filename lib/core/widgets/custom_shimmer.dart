import 'package:flutter/material.dart';

class CustomShimmer extends StatefulWidget {
  final Widget child;
  const CustomShimmer({super.key, required this.child});

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), // حركة أبطأ وأهدأ
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop, // لدمج الإضاءة فوق العناصر بنعومة
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
              colors: [
                Colors.grey.shade200, // لون هادئ جداً
                Colors.grey.shade50, // الوميض (اللمعة)
                Colors.grey.shade200, // عودة للهدوء
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
