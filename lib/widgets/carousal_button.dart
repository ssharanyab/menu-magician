import 'package:flutter/material.dart';

class CarousalButton extends StatelessWidget {
  const CarousalButton({
    required this.label,
    required this.icon,
    this.onPressed,
    super.key,
  });

  final String label;
  final IconData icon;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
    );
  }
}
