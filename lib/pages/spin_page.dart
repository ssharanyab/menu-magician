import 'package:flutter/material.dart';

class SpinPage extends StatefulWidget {
  const SpinPage({Key? key}) : super(key: key);

  @override
  State<SpinPage> createState() => _SpinPageState();
}

class _SpinPageState extends State<SpinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin'),
      ),
    );
  }
}
