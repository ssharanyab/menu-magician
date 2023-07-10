import 'package:flutter/material.dart';

class AppButtonIcon extends StatelessWidget {
  const AppButtonIcon({
    required this.onPressed,
    required this.label,
    required this.icon,
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
