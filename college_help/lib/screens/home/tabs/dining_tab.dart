import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../components/dining/featured_dining_card.dart';
import '../components/dining/menu_highlight_card.dart';
import '../components/dining/meal_plan_card.dart';
import '../components/dining/location_card.dart';
import '../components/dining/dietary_option_tile.dart';
import '../components/section_header.dart';

class DiningTab extends StatelessWidget {
  const DiningTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        // Header section
        const Text(
          'Dining at New College',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore dining options, meal plans, and special dietary services',
          style: TextStyle(fontSize: 16, color: AppColors.textLight),
        ),
        const SizedBox(height: 24),

        // Featured Dining Hall
        FeaturedDiningCard(
          name: 'Wilson Hall Dining Commons',
          description:
              'The main dining hall at New College, offering a diverse range of culinary options for students and faculty.',
          imageUrl: 'assets/images/dining_hall.jpg',
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Today's Menu section
        const SectionHeader(
          title: "Today's Menu Highlights",
          icon: Icons.restaurant,
        ),
        const SizedBox(height: 12),

        MenuHighlightCard(
          mealType: 'Breakfast',
          timeRange: '7:30 AM - 10:30 AM',
          highlights: [
            'Belgian Waffles with Fresh Berries',
            'Vegetable Frittata (Vegetarian)',
            'Assorted Breakfast Pastries',
            'Fresh Fruit Bar',
          ],
          icon: Icons.free_breakfast,
          onTap: () {},
        ),
        const SizedBox(height: 12),

        MenuHighlightCard(
          mealType: 'Lunch',
          timeRange: '11:30 AM - 2:30 PM',
          highlights: [
            'Herb Roasted Chicken with Potatoes',
            'Mushroom Risotto (Vegetarian)',
            'Build-Your-Own Sandwich Station',
            'Seasonal Soup Bar',
          ],
          icon: Icons.lunch_dining,
          onTap: () {},
        ),
        const SizedBox(height: 12),

        MenuHighlightCard(
          mealType: 'Dinner',
          timeRange: '5:00 PM - 8:00 PM',
          highlights: [
            'Salmon with Lemon Dill Sauce',
            'Eggplant Parmesan (Vegetarian)',
            'Stir-Fry Station (Vegan Options)',
            'Daily Special: Taco Tuesday',
          ],
          icon: Icons.dinner_dining,
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Meal Plan Options
        const SectionHeader(title: 'Meal Plan Options', icon: Icons.payment),
        const SizedBox(height: 12),
        MealPlanCard(
          title: 'Standard Meal Plan',
          description: '15 meals per week + \$100 flex dollars per semester',
          price: '\$2,400 per semester',
          features: [
            'Rollover meals within the week',
            'Guest passes (2 per month)',
            'Access to all campus dining locations',
          ],
          recommended: true,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        MealPlanCard(
          title: 'Premium Meal Plan',
          description: 'Unlimited meals + \$200 flex dollars per semester',
          price: '\$2,800 per semester',
          features: [
            'Unlimited dining hall access',
            'Guest passes (5 per month)',
            'Special event access',
            'Late night dining option',
          ],
          recommended: false,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        MealPlanCard(
          title: 'Basic Meal Plan',
          description: '10 meals per week + \$50 flex dollars per semester',
          price: '\$1,800 per semester',
          features: [
            'No rollover meals',
            'Guest passes (1 per month)',
            'Access to main dining hall only',
          ],
          recommended: false,
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Dining Locations
        const SectionHeader(
          title: 'Campus Dining Locations',
          icon: Icons.place,
        ),
        const SizedBox(height: 12),
        LocationCard(
          name: 'Wilson Hall Dining Commons',
          hours: 'Mon-Fri: 7:30 AM - 8:00 PM\nSat-Sun: 9:00 AM - 7:00 PM',
          description:
              'Main dining hall with multiple stations and rotating menu options.',
          icons: [Icons.accessible, Icons.eco, Icons.health_and_safety],
          onTap: () {},
        ),
        const SizedBox(height: 12),
        LocationCard(
          name: 'Wetmore Hall Café',
          hours: 'Mon-Fri: 8:00 AM - 2:00 PM\nClosed weekends',
          description:
              'Coffee, pastries, and grab-and-go sandwiches and salads.',
          icons: [Icons.eco, Icons.coffee],
          onTap: () {},
        ),
        const SizedBox(height: 12),
        LocationCard(
          name: '45 Willcocks Street Bistro',
          hours:
              'Mon-Thu: 11:00 AM - 7:00 PM\nFri: 11:00 AM - 3:00 PM\nClosed weekends',
          description:
              'À la carte dining with specialty items and international cuisine.',
          icons: [Icons.accessible, Icons.eco, Icons.local_bar],
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Dietary Accommodations
        const SectionHeader(
          title: 'Dietary Accommodations',
          icon: Icons.health_and_safety,
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            DietaryOptionTile(
              title: 'Vegetarian Options',
              description: 'Available at all stations in every dining location',
              icon: Icons.eco,
            ),
            DietaryOptionTile(
              title: 'Vegan Options',
              description:
                  'Dedicated vegan station at Wilson Hall and labeled options at all locations',
              icon: Icons.spa,
            ),
            DietaryOptionTile(
              title: 'Gluten-Free Options',
              description:
                  'Dedicated gluten-free prep area and labeled menu items',
              icon: Icons.do_not_touch,
            ),
            DietaryOptionTile(
              title: 'Halal Options',
              description: 'Available daily at Wilson Hall Dining Commons',
              icon: Icons.food_bank,
            ),
            DietaryOptionTile(
              title: 'Kosher Options',
              description: 'Available at 45 Willcocks Street Bistro',
              icon: Icons.synagogue,
            ),
            DietaryOptionTile(
              title: 'Food Allergy Accommodations',
              description:
                  'Individual consultations available with dining services',
              icon: Icons.coronavirus,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Feedback and Contact
        const SectionHeader(
          title: 'Feedback & Contact',
          icon: Icons.contact_support,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'We Value Your Feedback',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Help us improve your dining experience by sharing your thoughts and suggestions.',
                  style: TextStyle(fontSize: 14, color: AppColors.textDark),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.rate_review),
                        label: const Text('Submit Feedback'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.contact_mail),
                        label: const Text('Contact Us'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Dining Services Director:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('Sarah Johnson'),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      size: 14,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'dining@newcollege.utoronto.ca',
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 14,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '416-555-1234',
                      style: TextStyle(color: AppColors.textDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Extra space at bottom for better scrolling
        const SizedBox(height: 40),
      ],
    );
  }
}
