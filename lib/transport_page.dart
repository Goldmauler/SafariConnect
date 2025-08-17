import 'package:flutter/material.dart';

class TransportPage extends StatelessWidget {
  const TransportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transport')),
      body: const Center(child: Text('Transport - basic template')),
    );
  }
}
