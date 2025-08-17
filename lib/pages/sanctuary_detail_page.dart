// lib/pages/sanctuary_detail_page.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // You will need to add fl_chart to pubspec.yaml
import '../models/sanctuary_model.dart';

class SanctuaryDetailPage extends StatelessWidget {
  final Sanctuary sanctuary;

  const SanctuaryDetailPage({super.key, required this.sanctuary});

  @override
  Widget build(BuildContext context) {
    final List<Color> lineColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(sanctuary.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                sanctuary.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.image_not_supported, size: 50)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sanctuary.name,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    sanctuary.location,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const Divider(height: 32),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    sanctuary.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const Divider(height: 32),
                  Text(
                    'Population Trends',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: sanctuary.populationData.isNotEmpty
                        ? LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: false),
                              titlesData: const FlTitlesData(
                                leftTitles: AxisTitles(
                                    sideTitles:
                                        SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                    sideTitles:
                                        SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles:
                                        SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles:
                                        SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(show: true),
                              lineBarsData: List.generate(
                                sanctuary.populationData.keys.length,
                                (index) {
                                  String animal = sanctuary
                                      .populationData.keys
                                      .elementAt(index);
                                  List<int> populations =
                                      sanctuary.populationData[animal]!;
                                  return LineChartBarData(
                                    spots: List.generate(
                                      populations.length,
                                      (yearIndex) => FlSpot(
                                          yearIndex.toDouble(),
                                          populations[yearIndex].toDouble()),
                                    ),
                                    isCurved: true,
                                    color: lineColors[index % lineColors.length],
                                    barWidth: 4,
                                    isStrokeCapRound: true,
                                  );
                                },
                              ),
                            ),
                          )
                        : const Center(
                            child: Text("No population data available."),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}