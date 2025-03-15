import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'dart:math' as math;

class RegistrarTab extends StatefulWidget {
  const RegistrarTab({super.key});

  @override
  State<RegistrarTab> createState() => _RegistrarTabState();
}

class _RegistrarTabState extends State<RegistrarTab>
    with SingleTickerProviderStateMixin {
  // Store the selected service for detail view
  String? _selectedService;
  late AnimationController _animationController;

  // Define services with their icons and colors
  final List<ServiceItem> _services = [
    ServiceItem(
      title: 'Registration',
      icon: Icons.event_available,
      color: AppColors.primaryBlue,
      description: 'Course registration, dates, and enrollment information',
    ),
    ServiceItem(
      title: 'Records',
      icon: Icons.description,
      color: AppColors.info,
      description: 'Transcripts, verification, and student information',
    ),
    ServiceItem(
      title: 'Graduation',
      icon: Icons.school,
      color: AppColors.success,
      description: 'Requirements, application, and convocation details',
    ),
    ServiceItem(
      title: 'Forms',
      icon: Icons.content_paste,
      color: AppColors.warning,
      description: 'Common forms and submission information',
    ),
    ServiceItem(
      title: 'Calendar',
      icon: Icons.calendar_today,
      color: AppColors.secondaryRed,
      description: 'Academic calendar and important dates',
    ),
    ServiceItem(
      title: 'Contact Us',
      icon: Icons.support_agent,
      color: Colors.purple,
      description: 'Get help with registrar-related inquiries',
    ),
  ];

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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Enhanced Artistic Header
          _buildEnhancedHeader(context),

          // Main content area - replace TabBar with services grid or detail view
          Expanded(
            child:
                _selectedService == null
                    ? _buildServicesGrid()
                    : _buildServiceDetailView(_selectedService!),
          ),
        ],
      ),
    );
  }

  // Build enhanced artistic header
  Widget _buildEnhancedHeader(BuildContext context) {
    return Stack(
      children: [
        // Background gradient container with animated overlay
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryBlue,
                AppColors.primaryBlue.withOpacity(0.8),
                Color(0xFF1A3E78),
                Color(0xFF0F2652),
              ],
            ),
          ),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: WavePainter(animation: _animationController.value),
                child: child,
              );
            },
            child: const SizedBox.expand(),
          ),
        ),

        // Simplified content - combining title and subtitle elements
        Positioned(
          top: 30,
          left: 20,
          right: 20,
          child: Row(
            children: [
              // Vertical bar and title
              Container(
                height: 40,
                width: 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
              const SizedBox(width: 12),
              // Title and subtitle text combined
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Registrar\'s Office',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Smaller pill-style subtitles in a wrap for better space usage
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Academic',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Records',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Registration',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Compact artistic icon element
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Alert Banner
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondaryRed.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.secondaryRed.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.white.withOpacity(0.9),
                  size: 14,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Fall 2023 registration now open',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryRed.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Build the grid of service boxes
  Widget _buildServicesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Intro text
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Select a service',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Smaller spacing
        const SizedBox(height: 4),

        // Grid of services
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return _buildServiceBox(service);
              },
            ),
          ),
        ),
      ],
    );
  }

  // Build individual service box
  Widget _buildServiceBox(ServiceItem service) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedService = service.title;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: service.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(service.icon, color: service.color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              service.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                service.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the detail view for a selected service
  Widget _buildServiceDetailView(String serviceName) {
    return Stack(
      children: [
        // Content area with enhanced styling
        Column(
          children: [
            // Mini Header for each service view
            _buildServiceHeader(serviceName),

            // Content with animation
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _getServiceContent(serviceName),
              ),
            ),
          ],
        ),

        // Back button
        Positioned(
          top: 12,
          left: 16,
          child: FloatingActionButton.small(
            elevation: 2,
            backgroundColor: AppColors.primaryBlue,
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () {
              setState(() {
                _selectedService = null;
              });
            },
          ),
        ),
      ],
    );
  }

  // Build the mini-header for each service detail view
  Widget _buildServiceHeader(String serviceName) {
    // Get the service item data based on name
    final serviceItem = _services.firstWhere(
      (service) => service.title == serviceName,
      orElse: () => _services[0],
    );

    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [serviceItem.color, serviceItem.color.withOpacity(0.8)],
        ),
      ),
      child: Stack(
        children: [
          // Subtle wave decoration
          Positioned.fill(
            child: CustomPaint(
              painter: MiniWavePainter(color: Colors.white.withOpacity(0.1)),
            ),
          ),

          // Service icon and title
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 20, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(serviceItem.icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  serviceItem.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Return the appropriate content widget based on the selected service
  Widget _getServiceContent(String serviceName) {
    switch (serviceName) {
      case 'Registration':
        return _buildRegistrationTab();
      case 'Records':
        return _buildRecordsTab();
      case 'Graduation':
        return _buildGraduationTab();
      case 'Forms':
        return _buildFormsTab();
      case 'Calendar':
        return _buildCalendarTab();
      case 'Contact Us':
        return _buildContactTab();
      default:
        return const Center(child: Text('Service not found'));
    }
  }

  // Add a new contact tab
  Widget _buildContactTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        children: [
          const SectionTitle(title: 'Contact the Registrar\'s Office'),
          const SizedBox(height: 20),

          _buildContactCard(
            icon: Icons.location_on,
            title: 'Visit Us',
            content:
                'Student Services Building\n123 University Avenue\nRoom 301',
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            icon: Icons.email,
            title: 'Email Us',
            content:
                'registrar@university.edu\nResponse time: 1-2 business days',
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            icon: Icons.phone,
            title: 'Call Us',
            content: '(555) 123-4567\nMonday to Friday: 9:00 AM - 4:00 PM',
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            icon: Icons.chat,
            title: 'Live Chat',
            content: 'Available weekdays from 10:00 AM - 3:00 PM',
            hasAction: true,
            actionText: 'Start Chat',
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Frequently Asked Questions'),
          const SizedBox(height: 16),

          ExpansionTile(
            title: const Text('How do I request an official transcript?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'You can request an official transcript through ACORN or by submitting a Transcript Request Form to the Registrar\'s Office. Regular processing time is 3-5 business days.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('What\'s the deadline to drop a course?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'The deadline to drop courses varies by term. For F courses, the deadline is usually in November, and for S courses, it\'s typically in March. Check the Academic Calendar for exact dates.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do I declare my subject POSt?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'You can declare or change your subject POSt through ACORN during the program enrollment period, which typically runs from March to September.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String content,
    bool hasAction = false,
    String actionText = '',
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            if (hasAction) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(actionText),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        children: [
          const SectionTitle(title: 'Course Registration'),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.event_available,
            title: 'Registration Periods',
            content: 'Fall/Winter: July - September\nSummer: March - May',
            actionText: 'View Dates',
          ),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.computer,
            title: 'ACORN Registration System',
            content:
                'Access the university\'s online registration portal to enroll in courses, view timetables, and more.',
            actionText: 'Access ACORN',
          ),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.help_outline,
            title: 'Registration Help',
            content:
                'Need assistance with course registration? Our staff can help with enrollment issues, timetable conflicts, and waitlists.',
            actionText: 'Get Help',
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Important Dates'),
          const SizedBox(height: 12),
          DateCard(
            date: 'September 15, 2023',
            title: 'Last day to add F and Y courses',
            isUpcoming: true,
          ),
          const SizedBox(height: 8),
          DateCard(
            date: 'October 30, 2023',
            title: 'Last day to drop F courses without academic penalty',
            isUpcoming: true,
          ),
          const SizedBox(height: 8),
          DateCard(
            date: 'January 22, 2024',
            title: 'Last day to add S courses',
            isUpcoming: false,
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Enrollment Information'),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Full-Time Status',
            content:
                'Students must be enrolled in at least 3.0 credits over the Fall/Winter terms to be considered full-time.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Late Registration',
            content:
                'Late registration fees apply after the official registration period ends. Contact the Registrar\'s Office for assistance.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Waitlist Procedures',
            content:
                'If a course is full, you may join a waitlist. Check ACORN regularly for enrollment status changes.',
          ),
          const SizedBox(height: 30),

          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download),
            label: const Text('Download Registration Guide'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        children: [
          const SectionTitle(title: 'Academic Records & Transcripts'),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.description,
            title: 'Official Transcripts',
            content:
                'Order official transcripts for employment, graduate school applications, or other institutions.',
            actionText: 'Order Transcript',
          ),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.verified_user,
            title: 'Verification of Enrollment',
            content:
                'Request a verification letter confirming your enrollment status for insurance, government programs, or employers.',
            actionText: 'Request Letter',
          ),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.grade,
            title: 'Grade Reports',
            content:
                'View and download your grade reports and unofficial transcript through ACORN.',
            actionText: 'View Grades',
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Student Information'),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Update Personal Information',
            content:
                'Keep your contact information, address, and emergency contacts up to date through ACORN.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Legal Name Changes',
            content:
                'To change your legal name in university records, submit documentation to the Registrar\'s Office.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Privacy & FIPPA',
            content:
                'The university is bound by privacy legislation regarding the protection of your personal information.',
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Services & Fees'),
          const SizedBox(height: 12),
          ServiceFeeCard(
            service: 'Official Transcript',
            fee: '\$15.00 per copy',
            processingTime: '3-5 business days',
          ),
          const SizedBox(height: 8),
          ServiceFeeCard(
            service: 'Rush Transcript',
            fee: '\$30.00 per copy',
            processingTime: '1-2 business days',
          ),
          const SizedBox(height: 8),
          ServiceFeeCard(
            service: 'Enrollment Verification',
            fee: '\$10.00 per letter',
            processingTime: '3 business days',
          ),
          const SizedBox(height: 8),
          ServiceFeeCard(
            service: 'Replacement T-Card',
            fee: '\$20.00',
            processingTime: 'Same day',
          ),
        ],
      ),
    );
  }

  Widget _buildGraduationTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        children: [
          const SectionTitle(title: 'Graduation Requirements'),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Degree Requirements',
            content:
                'To graduate, students must complete at least 20.0 credits, satisfy program requirements, and maintain a cumulative GPA of at least 1.85.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Breadth Requirements',
            content:
                'Students must complete courses from each of the five breadth categories to ensure academic diversity.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Program Requirements',
            content:
                'Review your specific program requirements in the academic calendar or with your department advisor.',
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Graduation Process'),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.how_to_reg,
            title: 'Apply to Graduate',
            content:
                'Eligible students must apply to graduate on ACORN during the specified application period.',
            actionText: 'Apply Now',
          ),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.school,
            title: 'Convocation Ceremony',
            content:
                'Information about convocation dates, tickets, regalia rental, and ceremony details.',
            actionText: 'Ceremony Info',
          ),
          const SizedBox(height: 12),
          InformationCard(
            icon: Icons.card_membership,
            title: 'Diploma Information',
            content:
                'Learn about diploma pickup, delivery options, and replacement procedures.',
            actionText: 'Details',
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Important Graduation Dates'),
          const SizedBox(height: 12),
          DateCard(
            date: 'November 15, 2023',
            title: 'Fall convocation application deadline',
            isUpcoming: true,
          ),
          const SizedBox(height: 8),
          DateCard(
            date: 'February 20, 2024',
            title: 'Spring convocation application deadline',
            isUpcoming: false,
          ),
          const SizedBox(height: 8),
          DateCard(
            date: 'June 5-9, 2024',
            title: 'Spring convocation ceremonies',
            isUpcoming: false,
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Honors & Awards'),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Graduation with Distinction',
            content:
                'Students with a cumulative GPA of 3.50 or higher will graduate with distinction.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Dean\'s List',
            content:
                'Full-time students with a GPA of 3.50 or higher in their academic year will be named to the Dean\'s List.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Academic Awards',
            content:
                'Various scholarships and awards are available to graduating students based on academic achievement.',
          ),
        ],
      ),
    );
  }

  Widget _buildFormsTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        children: [
          const SectionTitle(title: 'Common Forms & Requests'),
          const SizedBox(height: 16),

          FormCard(
            title: 'Course Add/Drop Form',
            description: 'Use after online deadlines have passed',
            icon: Icons.playlist_add,
          ),
          const SizedBox(height: 12),
          FormCard(
            title: 'Program of Study Request',
            description: 'Change your subject POSt',
            icon: Icons.switch_account,
          ),
          const SizedBox(height: 12),
          FormCard(
            title: 'Petition for Late Withdrawal',
            description: 'Request withdrawal after the deadline',
            icon: Icons.history,
          ),
          const SizedBox(height: 12),
          FormCard(
            title: 'Transcript Request Form',
            description: 'For paper transcript requests',
            icon: Icons.description,
          ),
          const SizedBox(height: 12),
          FormCard(
            title: 'Letter of Permission',
            description: 'Take courses at another institution',
            icon: Icons.content_paste,
          ),
          const SizedBox(height: 12),
          FormCard(
            title: 'Final Exam Conflict Form',
            description: 'Report overlapping final exams',
            icon: Icons.event_busy,
          ),
          const SizedBox(height: 12),
          FormCard(
            title: 'Transfer Credit Assessment',
            description: 'Evaluate credits from other institutions',
            icon: Icons.compare_arrows,
          ),
          const SizedBox(height: 12),
          FormCard(
            title: 'Proof of Enrollment Request',
            description: 'Verification for third parties',
            icon: Icons.verified,
          ),
          const SizedBox(height: 20),

          const SectionTitle(title: 'Submission Information'),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Form Submission Methods',
            content:
                'Most forms can be submitted in person at the Registrar\'s Office, by email (scanned with signature), or through the college portal.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Processing Times',
            content:
                'Standard processing time for most forms is 5-7 business days. Expedited processing may be available for urgent requests.',
          ),
          const SizedBox(height: 12),
          const EnrollmentInfoCard(
            title: 'Required Documentation',
            content:
                'Many forms require supporting documentation. Please check the specific requirements for each form type.',
          ),
          const SizedBox(height: 20),

          Center(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.folder_open),
              label: const Text('View All Forms Repository'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
        children: [
          const SectionTitle(title: '2023-2024 Academic Calendar'),
          const SizedBox(height: 16),

          const CalendarSection(
            title: 'Fall Term 2023',
            events: [
              CalendarEvent(
                date: 'September 7',
                description: 'Classes begin',
                isImportant: true,
              ),
              CalendarEvent(
                date: 'September 21',
                description: 'Last day to add F and Y courses',
              ),
              CalendarEvent(
                date: 'October 9',
                description: 'Thanksgiving (University closed)',
              ),
              CalendarEvent(
                date: 'November 6-10',
                description: 'Fall reading week',
                isImportant: true,
              ),
              CalendarEvent(
                date: 'November 20',
                description: 'Last day to drop F courses',
              ),
              CalendarEvent(date: 'December 8', description: 'Classes end'),
              CalendarEvent(
                date: 'December 11-22',
                description: 'Final examination period',
                isImportant: true,
              ),
            ],
          ),

          const SizedBox(height: 20),

          const CalendarSection(
            title: 'Winter Term 2024',
            events: [
              CalendarEvent(
                date: 'January 8',
                description: 'Classes begin',
                isImportant: true,
              ),
              CalendarEvent(
                date: 'January 22',
                description: 'Last day to add S courses',
              ),
              CalendarEvent(
                date: 'February 19',
                description: 'Family Day (University closed)',
              ),
              CalendarEvent(
                date: 'February 19-23',
                description: 'Winter reading week',
                isImportant: true,
              ),
              CalendarEvent(
                date: 'March 18',
                description: 'Last day to drop Y/S courses',
              ),
              CalendarEvent(date: 'April 5', description: 'Classes end'),
              CalendarEvent(
                date: 'April 8-26',
                description: 'Final examination period',
                isImportant: true,
              ),
            ],
          ),

          const SizedBox(height: 20),

          const CalendarSection(
            title: 'Summer Term 2024',
            events: [
              CalendarEvent(
                date: 'May 6',
                description: 'F & Y classes begin',
                isImportant: true,
              ),
              CalendarEvent(
                date: 'May 20',
                description: 'Victoria Day (University closed)',
              ),
              CalendarEvent(
                date: 'June 17',
                description: 'Last day to drop F courses',
              ),
              CalendarEvent(date: 'June 24', description: 'F classes end'),
              CalendarEvent(
                date: 'July 1',
                description: 'Canada Day (University closed)',
              ),
              CalendarEvent(
                date: 'July 2',
                description: 'S classes begin',
                isImportant: true,
              ),
              CalendarEvent(
                date: 'August 5',
                description: 'Civic Holiday (University closed)',
              ),
              CalendarEvent(
                date: 'August 13',
                description: 'Last day to drop Y/S courses',
              ),
              CalendarEvent(date: 'August 20', description: 'Classes end'),
              CalendarEvent(
                date: 'August 22-26',
                description: 'Final examination period',
                isImportant: true,
              ),
            ],
          ),

          const SizedBox(height: 20),

          const SectionTitle(title: 'Other Important Dates'),
          const SizedBox(height: 12),

          const EnrollmentInfoCard(
            title: 'Convocation Dates',
            content:
                'Fall Convocation: November 6-10, 2023\nSpring Convocation: June 5-14, 2024',
          ),

          const SizedBox(height: 12),

          const EnrollmentInfoCard(
            title: 'University Closure',
            content:
                'Winter Break: December 23, 2023 - January 5, 2024\nThe university will be closed during this period.',
          ),

          const SizedBox(height: 20),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Download Calendar'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Add to My Calendar'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// UI Components

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 4),
        Container(height: 2, width: 40, color: AppColors.primaryBlue),
      ],
    );
  }
}

class InformationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final String actionText;

  const InformationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(actionText),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnrollmentInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const EnrollmentInfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  final String date;
  final String title;
  final bool isUpcoming;

  const DateCard({
    super.key,
    required this.date,
    required this.title,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color:
            isUpcoming ? AppColors.primaryBlue.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              isUpcoming
                  ? AppColors.primaryBlue.withOpacity(0.3)
                  : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isUpcoming
                      ? AppColors.primaryBlue.withOpacity(0.1)
                      : Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event,
              size: 16,
              color: isUpcoming ? AppColors.primaryBlue : Colors.grey[600],
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
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isUpcoming ? AppColors.primaryBlue : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: isUpcoming ? Colors.black87 : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          if (isUpcoming)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Upcoming',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ServiceFeeCard extends StatelessWidget {
  final String service;
  final String fee;
  final String processingTime;

  const ServiceFeeCard({
    super.key,
    required this.service,
    required this.fee,
    required this.processingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              service,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              fee,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              processingTime,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class FormCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const FormCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.download, color: Colors.grey[500], size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarSection extends StatelessWidget {
  final String title;
  final List<CalendarEvent> events;

  const CalendarSection({super.key, required this.title, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...events
            .map(
              (event) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                            event.isImportant
                                ? AppColors.primaryBlue.withOpacity(0.1)
                                : Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        event.date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color:
                              event.isImportant
                                  ? AppColors.primaryBlue
                                  : Colors.grey[800],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          event.description,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                event.isImportant
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class CalendarEvent {
  final String date;
  final String description;
  final bool isImportant;

  const CalendarEvent({
    required this.date,
    required this.description,
    this.isImportant = false,
  });
}

// Define a class for service items
class ServiceItem {
  final String title;
  final IconData icon;
  final Color color;
  final String description;

  ServiceItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
  });
}

// Wave animation painter for header background
class WavePainter extends CustomPainter {
  final double animation;

  WavePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    // First set of waves
    final paint1 =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.fill;

    // Second set of waves
    final paint2 =
        Paint()
          ..color = Colors.white.withOpacity(0.05)
          ..style = PaintingStyle.fill;

    const wavePeriod = 12.0; // Controls wave frequency
    const waveAmplitude = 7.0; // Reduced from 10.0

    final path1 = Path();
    final path2 = Path();

    // Setting start points - a bit higher in the header
    path1.moveTo(0, size.height * 0.6);
    path2.moveTo(0, size.height * 0.7);

    // First wave path
    for (double x = 0; x <= size.width; x++) {
      final y1 =
          size.height * 0.6 +
          math.sin(
                (x / size.width * wavePeriod * math.pi) +
                    animation * math.pi * 2,
              ) *
              waveAmplitude;
      path1.lineTo(x, y1);
    }

    // Complete first path
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    // Second wave path (offset)
    for (double x = 0; x <= size.width; x++) {
      final y2 =
          size.height * 0.7 +
          math.sin(
                (x / size.width * wavePeriod * math.pi) +
                    (animation + 0.5) * math.pi * 2,
              ) *
              waveAmplitude;
      path2.lineTo(x, y2);
    }

    // Complete second path
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    // Draw the paths
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);

    // Fewer particles for a cleaner look
    final particlePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.15)
          ..style = PaintingStyle.fill;

    // Generate some dots based on animation value
    for (int i = 0; i < 12; i++) {
      // Reduced from 20
      final particleX = size.width * ((i * 127) % 100) / 100;
      final particleY =
          size.height * 0.2 + ((i * 59) % 50) / 100 * size.height * 0.5;
      final particleSize = 0.8 + ((i * 13) % 3); // Smaller particles

      // Make particles pulse with the animation
      final pulseOffset =
          math.sin((animation * math.pi * 2) + (i / 10)) * 0.5 + 0.5;
      final particleOpacity = 0.08 + 0.08 * pulseOffset;

      particlePaint.color = Colors.white.withOpacity(particleOpacity);

      canvas.drawCircle(
        Offset(particleX, particleY),
        particleSize,
        particlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

// Simplified wave painter for service detail headers
class MiniWavePainter extends CustomPainter {
  final Color color;

  MiniWavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    // Simple wave pattern
    for (double x = 0; x <= size.width; x++) {
      final dx = x / size.width;
      final y = size.height * 0.7 + math.sin(dx * math.pi * 4) * 4;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant MiniWavePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
