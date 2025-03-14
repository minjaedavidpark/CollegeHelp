import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class RoomTypeCard extends StatelessWidget {
  final String type;
  final String description;
  final String imageUrl;
  final String price;
  final List<String> amenities;
  final bool isPopular;
  final VoidCallback onTap;

  const RoomTypeCard({
    super.key,
    required this.type,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.amenities,
    required this.isPopular,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room type header with price
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryRed,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryRed,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'POPULAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Room image and description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Room image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: _getImageWidget(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Room description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: onTap,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('View sample floor plan'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // Amenities
                const Text(
                  'Amenities',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // List of amenities with bullet points
                ...amenities.map(
                  (amenity) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 18)),
                        Expanded(
                          child: Text(
                            amenity,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                // Apply button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Apply for this Room Type'),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                child: const Icon(Icons.bed, size: 40, color: Colors.grey),
              );
            },
          );
        },
      );
    } catch (e) {
      return Container(
        color: Colors.grey[300],
        child: const Icon(Icons.bed, size: 40, color: Colors.grey),
      );
    }
  }
}
