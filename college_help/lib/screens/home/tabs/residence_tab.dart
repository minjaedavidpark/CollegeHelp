import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../components/section_header.dart';
import '../components/residence/residence_building_card.dart';
import '../components/residence/room_type_card.dart';
import '../components/residence/maintenance_request_card.dart';
import '../components/residence/residence_staff_card.dart';
import '../components/residence/faq_item.dart';

class ResidenceTab extends StatelessWidget {
  const ResidenceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        // Header section
        const Text(
          'Residence at New College',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore residence buildings, room options, and support services',
          style: TextStyle(fontSize: 16, color: AppColors.textLight),
        ),
        const SizedBox(height: 24),

        // Featured Banner for Move-In Information
        _buildMoveInBanner(),
        const SizedBox(height: 24),

        // Residence Buildings
        const SectionHeader(
          title: 'Residence Buildings',
          icon: Icons.apartment,
        ),
        const SizedBox(height: 16),
        ResidenceBuildingCard(
          name: 'Wilson Hall',
          description:
              'Modern residence hall with single and double rooms, common lounges on each floor, and air conditioning.',
          imageUrl: 'assets/images/wilson_hall.jpg',
          capacity: '250 students',
          features: [
            'Air Conditioning',
            'Common Kitchens',
            'Study Rooms',
            'Accessible Rooms',
            'Music Practice Room',
            'Elevator Access',
          ],
          onTap: () {},
        ),
        const SizedBox(height: 16),
        ResidenceBuildingCard(
          name: 'Wetmore Hall',
          description:
              'Traditional residence with a mix of single and double rooms. Located close to dining facilities and classrooms.',
          imageUrl: 'assets/images/wetmore_hall.jpg',
          capacity: '180 students',
          features: [
            'Common Lounges',
            'Laundry Facilities',
            'Study Spaces',
            'Game Room',
            'Close to Dining Hall',
          ],
          onTap: () {},
        ),
        const SizedBox(height: 16),
        ResidenceBuildingCard(
          name: '45 Willcocks',
          description:
              'Suite-style residence with apartment units for 4-6 students. Each suite includes a kitchen, living room, and private bathrooms.',
          imageUrl: 'assets/images/willcocks.jpg',
          capacity: '120 students',
          features: [
            'Full Kitchen',
            'Private Bathrooms',
            'Living Room',
            'High-Speed Internet',
            'In-Suite Laundry',
            'Modern Furnishings',
          ],
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Room Types
        const SectionHeader(title: 'Room Types', icon: Icons.bedroom_parent),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                'All rooms come furnished with a bed, desk, chair, wardrobe/closet, and high-speed internet.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('Compare All')),
          ],
        ),
        const SizedBox(height: 8),
        RoomTypeCard(
          type: 'Single Room',
          description:
              'Private room with shared bathroom facilities on the floor. Ideal for students who prefer their own space.',
          imageUrl: 'assets/images/single_room.jpg',
          price: '\$9,800 / academic year',
          amenities: [
            'Single Bed',
            'Personal Desk',
            'Wardrobe',
            'Shared Bathroom',
            'Approx. 100 sq ft',
          ],
          isPopular: true,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        RoomTypeCard(
          type: 'Double Room',
          description:
              'Shared room with one roommate and shared bathroom facilities on the floor. More affordable option.',
          imageUrl: 'assets/images/double_room.jpg',
          price: '\$8,200 / academic year',
          amenities: [
            'Two Single Beds',
            'Two Desks',
            'Shared Closet',
            'Shared Bathroom',
            'Approx. 180 sq ft',
          ],
          isPopular: false,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        RoomTypeCard(
          type: 'Suite',
          description:
              'Private bedroom in a shared suite with 3-5 other students. Includes a common living area and shared bathroom.',
          imageUrl: 'assets/images/suite.jpg',
          price: '\$11,400 / academic year',
          amenities: [
            'Single Bed',
            'Personal Desk',
            'Private/Shared Bathroom',
            'Shared Kitchen',
            'Shared Living Room',
            'Approx. 300-350 sq ft (suite)',
          ],
          isPopular: false,
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Maintenance
        const SectionHeader(
          title: 'Maintenance & Support',
          icon: Icons.support,
        ),
        const SizedBox(height: 16),
        MaintenanceRequestCard(onSubmit: () {}),
        const SizedBox(height: 24),

        // Residence Life Staff
        const SectionHeader(title: 'Residence Life Staff', icon: Icons.people),
        const SizedBox(height: 16),
        ResidenceStaffCard(
          name: 'Jennifer Thompson',
          position: 'Residence Director',
          imageUrl: 'assets/images/staff1.jpg',
          building: 'Wilson Hall, Office 101',
          email: 'jennifer.thompson@newcollege.utoronto.ca',
          phone: '416-555-1234',
          onTap: () {},
        ),
        const SizedBox(height: 16),
        ResidenceStaffCard(
          name: 'Michael Chen',
          position: 'Residence Life Coordinator',
          imageUrl: 'assets/images/staff2.jpg',
          building: 'Wetmore Hall, Office 202',
          email: 'michael.chen@newcollege.utoronto.ca',
          phone: '416-555-2345',
          onTap: () {},
        ),
        const SizedBox(height: 16),
        ResidenceStaffCard(
          name: 'Sarah Williams',
          position: 'Residence Don (Wilson 3rd Floor)',
          imageUrl: 'assets/images/staff3.jpg',
          building: 'Wilson Hall, Room 312',
          email: 'sarah.williams@mail.utoronto.ca',
          phone: '416-555-3456',
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // FAQs
        const SectionHeader(
          title: 'Frequently Asked Questions',
          icon: Icons.help,
        ),
        const SizedBox(height: 16),
        FaqItem(
          question: 'What items should I bring to residence?',
          answer:
              'You should bring bedding (twin XL), towels, toiletries, laptop, school supplies, clothing for all seasons, laundry supplies, and personal items. Prohibited items include candles, incense, cooking appliances, space heaters, and pets (except fish in small tanks).',
        ),
        const SizedBox(height: 8),
        FaqItem(
          question: 'When can I move into residence?',
          answer:
              'Move-in dates are typically the weekend before classes start in September. For the upcoming academic year, move-in dates are September 2-3, 2023. You\'ll receive a specific date and time slot via email approximately 2 weeks before move-in day.',
        ),
        const SizedBox(height: 8),
        FaqItem(
          question: 'Is there a curfew in residence?',
          answer:
              'No, there is no curfew in residence. Students may come and go as they please. However, quiet hours are in effect from 11:00 PM to 7:00 AM Sunday through Thursday, and 1:00 AM to 9:00 AM on Friday and Saturday.',
        ),
        const SizedBox(height: 8),
        FaqItem(
          question: 'How do I request a room change?',
          answer:
              'Room change requests can be submitted after the first two weeks of the term. Contact your Residence Don or the Residence Office to discuss your situation and fill out a room change request form. Requests are processed based on availability and need.',
        ),
        const SizedBox(height: 8),
        FaqItem(
          question: 'Can I stay in residence during winter break?',
          answer:
              'Yes, our residences remain open during winter break at no additional cost. However, dining hall hours may be limited, and some services might be reduced. You must register your intent to stay by December 1st through the Residence Portal.',
        ),
        const SizedBox(height: 8),
        FaqItem(
          question: 'How does the laundry service work?',
          answer:
              'Laundry facilities are available in each residence building. Washers and dryers operate using your TCard, which can be loaded with laundry funds through the eService Centre. Each wash cycle costs \$2.00 and each dry cycle costs \$1.50.',
        ),
        const SizedBox(height: 24),

        // Important Links
        const SectionHeader(title: 'Important Links', icon: Icons.link),
        const SizedBox(height: 16),
        _buildImportantLink(
          'Residence Handbook',
          'Download the complete guide to living in residence',
          Icons.menu_book,
        ),
        const SizedBox(height: 8),
        _buildImportantLink(
          'Residence Agreement',
          'Review the terms and conditions of your residence contract',
          Icons.description,
        ),
        const SizedBox(height: 8),
        _buildImportantLink(
          'Virtual Residence Tour',
          'Take a virtual tour of our residence buildings',
          Icons.view_in_ar,
        ),
        const SizedBox(height: 8),
        _buildImportantLink(
          'Housing Portal',
          'Access your housing application and room information',
          Icons.home,
        ),
        // Extra space at bottom for better scrolling
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildMoveInBanner() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.primaryBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'FALL 2023 MOVE-IN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Move-in dates: September 2-3, 2023',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Check your email for your specific time slot and building entrance information. Please follow the directions in your move-in guide to ensure a smooth process.',
              style: TextStyle(fontSize: 14, color: Colors.white, height: 1.4),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoChip('Map & Directions'),
                _buildInfoChip('Packing List'),
                _buildInfoChip('Move-in Guide'),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryBlue,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'JOIN MOVE-IN DAY CHAT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImportantLink(String title, String description, IconData icon) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaryBlue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 14, color: AppColors.textLight),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
