import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Search')),
            SizedBox(height: 12),
            Expanded(
              child: Center(child: Text('Search results will appear here')),
            ),
          ],
        ),
      ),
    );
  }
}
