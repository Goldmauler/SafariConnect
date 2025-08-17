import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafariConnect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://source.unsplash.com/random/800x600/?safari,wildlife',
                  ),
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

            // Featured Safaris
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured Safaris',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SizedBox(width: 16),
                  SafariCard(
                    imageUrl:
                        'https://source.unsplash.com/random/800x600/?lion',
                    title: 'Lion Kingdom',
                    location: 'Serengeti, Tanzania',
                  ),
                  SizedBox(width: 12),
                  SafariCard(
                    imageUrl:
                        'https://source.unsplash.com/random/800x600/?elephant',
                    title: 'Elephant Trail',
                    location: 'Chobe, Botswana',
                  ),
                  SizedBox(width: 12),
                  SafariCard(
                    imageUrl:
                        'https://source.unsplash.com/random/800x600/?gorilla',
                    title: 'Gorilla Trek',
                    location: 'Bwindi, Uganda',
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Plan Your Trip
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TripCategory(
                    icon: Icons.hotel,
                    label: 'Lodges',
                    onTap: () {},
                  ),
                  TripCategory(
                    icon: Icons.directions_car,
                    label: 'Transport',
                    onTap: () {},
                  ),
                  TripCategory(
                    icon: Icons.map,
                    label: 'Destinations',
                    onTap: () {},
                  ),
                  TripCategory(
                    icon: Icons.more_horiz,
                    label: 'More',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }
}

class SafariCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;

  const SafariCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
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

class TripCategory extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const TripCategory({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

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
