import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class FeaturedEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const FeaturedEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Event image with overlay
            SizedBox(
              height: 180,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildEventImage(),
                  // Gradient overlay for text visibility
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
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
                  // Event date badge
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _getMonth(date),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _getDay(date),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Event title overlay
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Event details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time and location
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textDark,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today, size: 16),
                        label: const Text('Add to Calendar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue,
                          side: BorderSide(color: AppColors.primaryBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: 16),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue,
                          side: BorderSide(color: AppColors.primaryBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Return a placeholder if the image fails to load
        return Container(
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.image, size: 64, color: Colors.grey),
          ),
        );
      },
    );
  }

  String _getMonth(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      switch (date.month) {
        case 1:
          return 'JAN';
        case 2:
          return 'FEB';
        case 3:
          return 'MAR';
        case 4:
          return 'APR';
        case 5:
          return 'MAY';
        case 6:
          return 'JUN';
        case 7:
          return 'JUL';
        case 8:
          return 'AUG';
        case 9:
          return 'SEP';
        case 10:
          return 'OCT';
        case 11:
          return 'NOV';
        case 12:
          return 'DEC';
        default:
          return '';
      }
    } catch (e) {
      // Fallback for non-standard date formats
      if (dateStr.contains('January')) return 'JAN';
      if (dateStr.contains('February')) return 'FEB';
      if (dateStr.contains('March')) return 'MAR';
      if (dateStr.contains('April')) return 'APR';
      if (dateStr.contains('May')) return 'MAY';
      if (dateStr.contains('June')) return 'JUN';
      if (dateStr.contains('July')) return 'JUL';
      if (dateStr.contains('August')) return 'AUG';
      if (dateStr.contains('September')) return 'SEP';
      if (dateStr.contains('October')) return 'OCT';
      if (dateStr.contains('November')) return 'NOV';
      if (dateStr.contains('December')) return 'DEC';
      return dateStr.substring(0, 3).toUpperCase();
    }
  }

  String _getDay(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return date.day.toString();
    } catch (e) {
      // Extract day from string like "September 5, 2023"
      final regex = RegExp(r'(\d+)');
      final match = regex.firstMatch(dateStr);
      if (match != null) {
        return match.group(1) ?? '';
      }
      return '';
    }
  }
}
