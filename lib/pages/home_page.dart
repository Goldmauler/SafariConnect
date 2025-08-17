// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import '../models/sanctuary_model.dart';
import '../services/firestore_service.dart';
import 'sanctuary_detail_page.dart'; // Import the new detail page
import 'travel_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // This instance will be used to fetch data from Firebase
    final FirestoreService firestoreService = FirestoreService();

    // No Scaffold or BottomNavBar here anymore
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafariConnect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Handle search action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section (Your code is fine)
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://source.unsplash.com/random/800x600/?safari,wildlife,india'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Explore the Wild',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Featured Safaris Section (Now connected to Firebase)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured Sanctuaries',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              // We use StreamBuilder to get live data from Firestore
              child: StreamBuilder<List<Sanctuary>>(
                stream: firestoreService.getFeaturedSanctuaries(),
                builder: (context, snapshot) {
                  // Show a loading circle while data is being fetched
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Show an error message if something goes wrong
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Could not load featured spots.'));
                  }
                  // Show a message if there's no data
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nothing to feature.'));
                  }

                  // If we have data, store it in a list
                  final featuredSanctuaries = snapshot.data!;

                  // Build the horizontal list using the live data
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredSanctuaries.length,
                    itemBuilder: (context, index) {
                      final sanctuary = featuredSanctuaries[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 16.0 : 0, right: 12.0),
                        // Using a new, cleaner SafariCard widget
                        child: SafariCard(sanctuary: sanctuary),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Plan Your Trip Section (Your code is fine, just updated the nav)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Plan Your Trip',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TripCategory(
                      icon: Icons.hotel, label: 'Lodges', onTap: () {}),
                  TripCategory(
                      icon: Icons.directions_car,
                      label: 'Transport',
                      onTap: () {}),
                  TripCategory(
                      icon: Icons.map, label: 'Destinations', onTap: () {}),
                  TripCategory(
                    icon: Icons.menu_book,
                    label: 'Travel Guide',
                    onTap: () {
                      // This can still navigate to your travel page
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const TravelPage(
                              title: "General Travel Guide",
                              budget: 2500,
                              days: 7)));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// A new, cleaner SafariCard that takes the whole Sanctuary object
class SafariCard extends StatelessWidget {
  final Sanctuary sanctuary;

  const SafariCard({super.key, required this.sanctuary});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            // Navigate to the new detail page when tapped
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SanctuaryDetailPage(sanctuary: sanctuary),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                sanctuary.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(height: 120, child: Icon(Icons.broken_image)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sanctuary.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sanctuary.location,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Your TripCategory widget is fine, no changes needed
class TripCategory extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const TripCategory(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal.withOpacity(0.1),
            child: Icon(icon, size: 30, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}