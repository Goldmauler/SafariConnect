import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class TravelPage extends StatelessWidget {
  final String title;
  final String?
  imageUrl; // can be a normal URL or a data:image/...;base64,... URI
  final int budget;
  final int days;

  const TravelPage({
    super.key,
    required this.title,
    this.imageUrl,
    required this.budget,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    // If imageUrl is a data URI (data:image/...;base64,...), decode it and show via Image.memory
    Uint8List? logoBytes;
    if (imageUrl != null && imageUrl!.startsWith('data:')) {
      try {
        final parts = imageUrl!.split(',');
        final b64 = parts.length > 1 ? parts.last : '';
        if (b64.isNotEmpty) {
          logoBytes = base64Decode(b64);
        }
      } catch (_) {
        logoBytes = null;
      }
    }

    final inclusions = [
      'Park entry fees',
      'Guided game drives',
      'Accommodation (3-star)',
      'Meals',
      'Airport transfers',
    ];

    // additional gallery images (user requested one added)
    final galleryImages = <String>[];
    if (imageUrl != null && !imageUrl!.startsWith('data:')) {
      galleryImages.add(imageUrl!);
    }
    // user-provided image to add
    galleryImages.add(
      'https://images.squarespace-cdn.com/content/v1/5bc717b929f2cc0b619dbff7/1559730638325-R97Y9K0OTJXV2B5SPKJ6/ke17ZwdGBToddI8pDm48kOyctPanBqSdf7WQMpY1FsRZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpwwQIrqN0bcqL_6-iJCOAA0qwytzcs0JTq1XS2aqVbyK6GtMIM7F0DGeOwCXa63_4k/Great+Grey+Owl+Portrait+(monochrome)_600px%2C+web%2C+large_%C2%A9+Paul+J+Coghlin.jpg',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Travel Guide')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo or hero image
            if (logoBytes != null)
              Center(
                child: Image.memory(
                  logoBytes,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              )
            else if (imageUrl != null)
              Center(
                child: Image.network(
                  imageUrl!,
                  width: 200,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (c, e, s) => const Icon(Icons.travel_explore, size: 72),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Gallery thumbnails
            if (galleryImages.isNotEmpty)
              SizedBox(
                height: 84,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: galleryImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, idx) {
                    final url = galleryImages[idx];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => Dialog(
                                child: InteractiveViewer(
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (c, e, s) => const SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Center(
                                            child: Icon(Icons.broken_image),
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          url,
                          width: 140,
                          height: 84,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (c, e, s) => const SizedBox(
                                width: 140,
                                height: 84,
                                child: Center(child: Icon(Icons.broken_image)),
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),
            Text(
              'Safari Budget',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated budget: \$${budget}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Duration: $days days'),
                    const SizedBox(height: 8),
                    const Text('Per person estimate includes:'),
                    const SizedBox(height: 6),
                    ...inclusions.map(
                      (s) => Row(
                        children: [
                          const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(s)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Trip Planner',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('1. Choose your dates'),
                    SizedBox(height: 6),
                    Text('2. Pick accommodations and upgrades'),
                    SizedBox(height: 6),
                    Text(
                      '3. Add extra experiences (night drives, walking safaris)',
                    ),
                    SizedBox(height: 6),
                    Text('4. Review and confirm bookings'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tips & Notes',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '- Best time to visit: Dry season for wildlife sightings.',
                    ),
                    SizedBox(height: 6),
                    Text(
                      '- Health: Check vaccinations and bring malaria precautions.',
                    ),
                    SizedBox(height: 6),
                    Text(
                      '- Packing: Light layers, binoculars, camera, sun protection.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.book_online),
                label: const Text('Book This Safari'),
                onPressed: () {
                  // TODO: Hook booking flow
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking flow not implemented yet'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
