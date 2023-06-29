import 'package:flutter/material.dart';

class CarousalCard extends StatelessWidget {
  const CarousalCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.lightGreen[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
