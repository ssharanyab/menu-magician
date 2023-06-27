import 'package:flutter/material.dart';

class TabBarIcon extends StatelessWidget {
  const TabBarIcon({
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
