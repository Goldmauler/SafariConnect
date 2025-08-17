import 'package:flutter/material.dart';

class LodgesPage extends StatelessWidget {
  const LodgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lodges')),
      body: const Center(child: Text('Lodges - basic template')),
    );
  }
}
