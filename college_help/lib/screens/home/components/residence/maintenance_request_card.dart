import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class MaintenanceRequestCard extends StatelessWidget {
  final VoidCallback onSubmit;

  const MaintenanceRequestCard({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.build_rounded,
                    color: AppColors.primaryBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Maintenance Request',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Submit a request for repairs or maintenance issues',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Common Issues:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildQuickRequestButton(
                  'Plumbing',
                  Icons.water_damage,
                  context,
                ),
                _buildQuickRequestButton(
                  'Electrical',
                  Icons.electrical_services,
                  context,
                ),
                _buildQuickRequestButton('Heating', Icons.thermostat, context),
                _buildQuickRequestButton('Furniture', Icons.chair, context),
                _buildQuickRequestButton('Locks/Keys', Icons.key, context),
                _buildQuickRequestButton(
                  'Cleaning',
                  Icons.cleaning_services,
                  context,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Submit a New Request:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Describe your maintenance issue...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Add Photo'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Schedule'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('SUBMIT REQUEST'),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Emergency? Call Residence Services at 416-555-1234',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickRequestButton(
    String label,
    IconData icon,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.textDark),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}
