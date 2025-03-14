import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class EventDetailCard extends StatelessWidget {
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final String location;
  final String description;
  final String organizer;
  final String imageUrl;
  final List<String> tags;
  final bool isRSVPRequired;
  final VoidCallback onRSVP;
  final VoidCallback onShare;
  final VoidCallback onSaveToCalendar;

  const EventDetailCard({
    super.key,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.description,
    required this.organizer,
    required this.imageUrl,
    required this.tags,
    required this.isRSVPRequired,
    required this.onRSVP,
    required this.onShare,
    required this.onSaveToCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Event image
          SizedBox(height: 200, child: _buildEventImage()),
          // Event content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and date
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 16),
                // Date and time section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          size: 24,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$startTime - $endTime',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          color: AppColors.primaryBlue,
                        ),
                        onPressed: onSaveToCalendar,
                        tooltip: 'Add to Calendar',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Location section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on,
                          size: 24,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textLight,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              location,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.map, color: AppColors.primaryBlue),
                        onPressed: () {},
                        tooltip: 'View Map',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Description
                const Text(
                  'About This Event',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textDark,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                // Organizer info
                Row(
                  children: [
                    Text(
                      'Organized by:',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      organizer,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Tags
                if (tags.isNotEmpty) ...[
                  const Text(
                    'Tags',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.map((tag) => _buildTagChip(tag)).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onRSVP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isRSVPRequired ? 'RSVP Now' : 'I\'m Interested',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.share, color: AppColors.primaryBlue),
                      onPressed: onShare,
                      tooltip: 'Share Event',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.secondaryRed.withOpacity(0.3)),
      ),
      child: Text(
        tag,
        style: TextStyle(fontSize: 12, color: AppColors.secondaryRed),
      ),
    );
  }

  Widget _buildEventImage() {
    try {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/placeholder.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderImage();
            },
          );
        },
      );
    } catch (e) {
      return _buildPlaceholderImage();
    }
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColors.primaryBlue.withOpacity(0.1),
      width: double.infinity,
      child: Center(
        child: Icon(
          Icons.event,
          size: 80,
          color: AppColors.primaryBlue.withOpacity(0.3),
        ),
      ),
    );
  }
}
