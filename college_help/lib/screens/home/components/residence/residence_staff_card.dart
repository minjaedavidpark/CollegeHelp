import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class ResidenceStaffCard extends StatelessWidget {
  final String name;
  final String position;
  final String imageUrl;
  final String building;
  final String email;
  final String phone;
  final VoidCallback onTap;

  const ResidenceStaffCard({
    super.key,
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.building,
    required this.email,
    required this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                backgroundImage: _getImageProvider(),
                child: _buildImagePlaceholder(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      position,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryRed,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.apartment,
                          size: 14,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            building,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.email, size: 14, color: AppColors.textLight),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            email,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryBlue,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14, color: AppColors.textLight),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            phone,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.email, size: 16),
                            label: const Text('Email'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.calendar_month, size: 16),
                            label: const Text('Book Meeting'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 4),
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
      ),
    );
  }

  ImageProvider? _getImageProvider() {
    try {
      return AssetImage(imageUrl);
    } catch (e) {
      return null;
    }
  }

  Widget? _buildImagePlaceholder() {
    try {
      // If image loads successfully, don't show placeholder
      AssetImage(imageUrl);
      return null;
    } catch (e) {
      // If image fails to load, show placeholder
      return Icon(Icons.person, size: 40, color: AppColors.primaryBlue);
    }
  }
}
