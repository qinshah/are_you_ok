import 'package:flutter/material.dart';

class DoSomethingPage extends StatelessWidget {
  const DoSomethingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('要做什么呢')),
      body: ListView(),
    );
  }
}
