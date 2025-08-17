import 'package:flutter/material.dart';
import 'travel_page.dart';

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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/hero.jpg',
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Image.network(
                          'https://i.pinimg.com/originals/00/93/78/009378599f4497822396d943d6401840.png',
                          fit: BoxFit.cover,
                        ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
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
                ],
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
                        'https://th.bing.com/th/id/R.8f20fea13be66cb0a298e468b95cb06a?rik=tqAm55XLfPYASw&riu=http%3a%2f%2fthewowstyle.com%2fwp-content%2fuploads%2f2015%2f01%2fwildlife-photography-ideas.jpg&ehk=5Bw9P%2bkkuAEfBJ8x%2ftlWilLcyWSb%2f2vCZc7fu3cB3Bk%3d&risl=&pid=ImgRaw&r=0',
                    title: 'Lion Kingdom',
                    location: 'Serengeti, Tanzania',
                  ),
                  SizedBox(width: 12),
                  SafariCard(
                    imageUrl:
                        'https://i.pinimg.com/originals/38/15/93/3815935292dfa59c05ec1c9b9893fce1.jpg',
                    title: 'Elephant Trail',
                    location: 'Chobe, Botswana',
                  ),
                  SizedBox(width: 12),
                  SafariCard(
                    imageUrl:
                        'https://th.bing.com/th/id/OIP.T_PgpAcF4VoCKt-aSqL5yAHaEL?w=316&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7',
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
                    icon: Icons.menu_book,
                    label: 'Travel Guide',
                    onTap: () {
                      Navigator.of(context).pushNamed('/travel');
                    },
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
  final int budget;
  final int days;

  const SafariCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    this.budget = 1500,
    this.days = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => TravelPage(
                    title: title,
                    imageUrl: imageUrl,
                    budget: budget,
                    days: days,
                  ),
            ),
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
