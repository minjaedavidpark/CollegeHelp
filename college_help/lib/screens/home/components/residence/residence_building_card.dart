import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class ResidenceBuildingCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String capacity;
  final List<String> features;
  final VoidCallback onTap;

  const ResidenceBuildingCard({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.capacity,
    required this.features,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Building Image
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _getImageWidget(),
                  // Gradient overlay for text readability
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Building name overlay
                  Positioned(
                    bottom: 12,
                    left: 16,
                    right: 16,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Building information
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  // Capacity
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.people,
                          color: AppColors.primaryBlue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Capacity: $capacity',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Features
                  const Text(
                    'Features',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        features
                            .map((feature) => _buildFeatureChip(feature))
                            .toList(),
                  ),
                  const SizedBox(height: 16),
                  // View Details Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: onTap,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primaryBlue),
                      ),
                      child: const Text('View Floor Plans & Details'),
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

  Widget _buildFeatureChip(String feature) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.secondaryRed.withOpacity(0.3)),
      ),
      child: Text(
        feature,
        style: TextStyle(fontSize: 12, color: AppColors.secondaryRed),
      ),
    );
  }

  Widget _getImageWidget() {
    try {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/placeholder.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(
                  Icons.apartment,
                  size: 50,
                  color: Colors.grey,
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      return Container(
        color: Colors.grey[300],
        child: const Icon(Icons.apartment, size: 50, color: Colors.grey),
      );
    }
  }
}
