// lib/models/sanctuary_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Sanctuary {
  final String id; // Add ID for unique identification
  final String name;
  final String location;
  final String imageUrl;
  final String description;
  final List<String> commonAnimals;
  final String entryFee;
  final String timings;
  final Map<String, List<int>> populationData;

  const Sanctuary({
    required this.id, // Add to constructor
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.commonAnimals,
    required this.entryFee,
    required this.timings,
    required this.populationData,
  });

  // Factory constructor to create a Sanctuary from a Firestore document
  factory Sanctuary.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Helper to convert dynamic population data to Map<String, List<int>>
    Map<String, List<int>> parsePopulationData(Map<String, dynamic> rawData) {
        Map<String, List<int>> parsedData = {};
        rawData.forEach((key, value) {
            if (value is List) {
                parsedData[key] = List<int>.from(value.map((item) => item as int));
            }
        });
        return parsedData;
    }

    return Sanctuary(
      id: doc.id,
      name: data['name'] ?? 'No Name',
      location: data['location'] ?? 'No Location',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? 'No Description',
      commonAnimals: List<String>.from(data['commonAnimals'] ?? []),
      entryFee: data['entryFee'] ?? 'N/A',
      timings: data['timings'] ?? 'N/A',
      populationData: parsePopulationData(data['populationData'] ?? {}),
    );
  }
}