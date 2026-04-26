import 'package:flutter/material.dart';

class CustomBuildTabName extends StatelessWidget {
  final String tap;
  const CustomBuildTabName({required this.tap, super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        tap,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
