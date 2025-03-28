import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'tabs/home_tab.dart';
import 'tabs/dining_tab.dart';
import 'tabs/residence_tab.dart';
import 'tabs/events_tab.dart';
import 'tabs/registrar_tab.dart';
import '../auth/login_screen.dart';
import 'components/app_bar/enhanced_app_bar.dart';
import 'components/profile/profile_menu.dart';

class HomeScreen extends StatefulWidget {
  final bool isGuest;

  const HomeScreen({super.key, this.isGuest = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  final List<String> _tabTitles = [
    'Home',
    'Dining',
    'Residence',
    'Events',
    'Registrar\'s Office',
  ];

  // Add unread notifications counter
  int _unreadNotificationsCount = 2; // Starting with 2 unread notifications

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      endDrawer: ProfileMenu(onLogout: () => _performLogout(context)),
      body: Container(
        // Add a subtle gradient to the entire app background
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[100]!],
            stops: const [0.85, 1.0],
          ),
        ),
        child: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              HomeTab(isGuest: widget.isGuest, onViewAll: _handleViewAll),
              const DiningTab(),
              const ResidenceTab(),
              const EventsTab(),
              const RegistrarTab(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Replace _buildEnhancedAppBar with _buildAppBar that uses the EnhancedAppBar component
  PreferredSizeWidget _buildAppBar() {
    return EnhancedAppBar(
      animationController: _animationController,
      unreadNotificationsCount: _unreadNotificationsCount,
      onUnreadCountChanged: (count) {
        setState(() {
          _unreadNotificationsCount = count;
        });
      },
      onProfileTap: _showProfileMenu,
    );
  }

  void _showProfileMenu() {
    Scaffold.of(context).openEndDrawer();
  }

  void _performLogout(BuildContext context) {
    // Navigate directly to the login screen and clear navigation stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false, // Remove all previous routes
    );
  }

  // Keep the remaining methods that are not related to the app bar
  // Rest of the HomeScreen implementation...

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: _tabTitles[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.restaurant_outlined),
              activeIcon: const Icon(Icons.restaurant),
              label: _tabTitles[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.apartment_outlined),
              activeIcon: const Icon(Icons.apartment),
              label: _tabTitles[2],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.event_outlined),
              activeIcon: const Icon(Icons.event),
              label: _tabTitles[3],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school_outlined),
              activeIcon: const Icon(Icons.school),
              label: _tabTitles[4],
            ),
          ],
        ),
      ),
    );
  }

  // Handle view all buttons on cards
  void _handleViewAll(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('View all $section - Coming soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
