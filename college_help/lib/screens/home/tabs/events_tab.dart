import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'package:intl/intl.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  int _selectedTabIndex = 0;
  final List<String> _tabNames = ['Upcoming', 'Calendar', 'Categories'];

  // Current selected date in calendar view
  DateTime _selectedDate = DateTime.now();
  // Current viewed month in calendar
  DateTime _currentMonth = DateTime.now();

  // Dummy dates with events
  final List<DateTime> _datesWithEvents = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 7)),
    DateTime.now().add(const Duration(days: 10)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 15)),
    DateTime.now().add(const Duration(days: 22)),
  ];

  // Dummy events data
  final List<_EventItem> _allEvents = [];

  @override
  void initState() {
    super.initState();
    _initializeDummyEvents();
  }

  void _initializeDummyEvents() {
    // Current date for reference
    final now = DateTime.now();

    // Upcoming events (this week and next week)
    _allEvents.addAll([
      _EventItem(
        title: 'Welcome Week Gala',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 2))),
        time: '7:00 PM - 10:00 PM',
        location: 'Wilson Hall Auditorium',
        description:
            'Join us for an evening of celebration, food, and entertainment as we welcome new and returning students to New College. Meet faculty, staff, and fellow students in this grand kickoff to the academic year.',
        category: 'Social',
        isHighlighted: true,
      ),
      _EventItem(
        title: 'Academic Success Workshop',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 4))),
        time: '2:00 PM - 3:30 PM',
        location: 'Wetmore Hall Study Room B',
        description:
            'Learn essential study strategies, time management techniques, and resources to help you succeed academically this semester.',
        category: 'Academic',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Intramural Basketball Signup',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 5))),
        time: '10:00 AM - 4:00 PM',
        location: 'Athletic Center, Room 202',
        description:
            'Sign up for the fall intramural basketball league. All skill levels welcome! Teams of 5-7 players.',
        category: 'Sports',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'International Student Mixer',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 7))),
        time: '6:00 PM - 8:00 PM',
        location: 'Wilson Hall Common Room',
        description:
            'A social gathering for international students to meet each other and connect with the international student services team.',
        category: 'Social',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Career Services Resume Workshop',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 9))),
        time: '1:00 PM - 3:00 PM',
        location: 'Career Center, Room 101',
        description:
            'Bring your resume for personalized feedback from career counselors. Learn how to highlight your skills and experiences effectively.',
        category: 'Career',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Student Council Meeting',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 10))),
        time: '5:30 PM - 7:00 PM',
        location: 'Student Union, 2nd Floor',
        description:
            'Biweekly meeting of the student council. All students are welcome to attend and voice their concerns or ideas.',
        category: 'Academic',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Art Exhibition Opening',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 12))),
        time: '6:00 PM - 9:00 PM',
        location: 'Campus Gallery',
        description:
            'Opening reception for "New Perspectives," featuring artwork by students and faculty. Refreshments will be served.',
        category: 'Arts & Culture',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Meditation and Mindfulness',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 14))),
        time: '8:00 AM - 9:00 AM',
        location: 'Wellness Center, Room 3',
        description:
            'Start your day with guided meditation and mindfulness practices. No experience necessary. Mats provided.',
        category: 'Health & Wellness',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Guest Lecture: Climate Science',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 15))),
        time: '4:00 PM - 5:30 PM',
        location: 'Science Building, Auditorium',
        description:
            'Dr. Maria Chen from Stanford University will discuss recent developments in climate science and policy implications.',
        category: 'Academic',
        isHighlighted: true,
      ),
      _EventItem(
        title: 'Fall Festival',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 20))),
        time: '12:00 PM - 6:00 PM',
        location: 'Main Quad',
        description:
            'Annual fall festival with food, games, music, and activities. Join us for this community-wide celebration!',
        category: 'Social',
        isHighlighted: true,
      ),
    ]);
  }

  // Get events for a specific date
  List<_EventItem> _getEventsForDate(DateTime date) {
    return _allEvents.where((event) {
      final eventDate = DateFormat('MMM d, yyyy').parse(event.date);
      return eventDate.year == date.year &&
          eventDate.month == date.month &&
          eventDate.day == date.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16.0),
              color: AppColors.primaryBlue,
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'College Events',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Stay updated with campus activities',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(
                  _tabNames.length,
                  (index) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  _selectedTabIndex == index
                                      ? AppColors.primaryBlue
                                      : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          _tabNames[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                _selectedTabIndex == index
                                    ? AppColors.primaryBlue
                                    : Colors.grey,
                            fontWeight:
                                _selectedTabIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildUpcomingEvents();
      case 1:
        return _buildCalendarView();
      case 2:
        return _buildCategoriesView();
      default:
        return _buildUpcomingEvents();
    }
  }

  Widget _buildUpcomingEvents() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _allEvents.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildEventCard(_allEvents[index]),
        );
      },
    );
  }

  Widget _buildCalendarView() {
    return Column(
      children: [
        _buildMonthCalendar(),
        const Divider(height: 1),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.event, color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                'Events on ${DateFormat('MMMM d, yyyy').format(_selectedDate)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: _buildEventsForSelectedDate()),
      ],
    );
  }

  Widget _buildMonthCalendar() {
    return Column(
      children: [
        // Month navigation
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(
                      _currentMonth.year,
                      _currentMonth.month - 1,
                      1,
                    );
                  });
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(
                      _currentMonth.year,
                      _currentMonth.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
        ),

        // Days of week header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: const [
              Expanded(child: _WeekdayLabel('Sun')),
              Expanded(child: _WeekdayLabel('Mon')),
              Expanded(child: _WeekdayLabel('Tue')),
              Expanded(child: _WeekdayLabel('Wed')),
              Expanded(child: _WeekdayLabel('Thu')),
              Expanded(child: _WeekdayLabel('Fri')),
              Expanded(child: _WeekdayLabel('Sat')),
            ],
          ),
        ),

        // Calendar grid
        Container(
          margin: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemCount: _getDaysInMonthWithPadding().length,
            itemBuilder: (context, index) {
              final day = _getDaysInMonthWithPadding()[index];

              // Check if this date has events
              final hasEvents =
                  day != null &&
                  _datesWithEvents.any(
                    (date) =>
                        date.year == day.year &&
                        date.month == day.month &&
                        date.day == day.day,
                  );

              // Check if this is the selected date
              final isSelected =
                  day != null &&
                  day.year == _selectedDate.year &&
                  day.month == _selectedDate.month &&
                  day.day == _selectedDate.day;

              // Check if this is today
              final isToday =
                  day != null &&
                  day.year == DateTime.now().year &&
                  day.month == DateTime.now().month &&
                  day.day == DateTime.now().day;

              // Check if date is in current month
              final isCurrentMonth =
                  day != null && day.month == _currentMonth.month;

              return _buildCalendarDay(
                day,
                isCurrentMonth,
                hasEvents,
                isSelected,
                isToday,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarDay(
    DateTime? day,
    bool isCurrentMonth,
    bool hasEvents,
    bool isSelected,
    bool isToday,
  ) {
    return GestureDetector(
      onTap:
          day != null
              ? () {
                setState(() {
                  _selectedDate = day;
                });
              }
              : null,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primaryBlue
                  : isToday
                  ? AppColors.primaryBlue.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border:
              isToday && !isSelected
                  ? Border.all(color: AppColors.primaryBlue)
                  : null,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day != null ? day.day.toString() : '',
                style: TextStyle(
                  fontWeight:
                      isToday || isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                  color:
                      isSelected
                          ? Colors.white
                          : !isCurrentMonth
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.black87,
                ),
              ),
              if (hasEvents)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.white : AppColors.primaryBlue,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventsForSelectedDate() {
    final eventsForDate = _getEventsForDate(_selectedDate);

    if (eventsForDate.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No events on this date',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: eventsForDate.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildEventCard(eventsForDate[index]),
        );
      },
    );
  }

  List<DateTime?> _getDaysInMonthWithPadding() {
    final List<DateTime?> days = [];

    // First day of the month
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);

    // Last day of the month
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    // Add padding for days before the first day of the month
    int padding = firstDay.weekday % 7;
    for (int i = 0; i < padding; i++) {
      days.add(null);
    }

    // Add all days of the month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    // Add padding at the end to make the grid complete rows
    while (days.length % 7 != 0) {
      days.add(null);
    }

    return days;
  }

  Widget _buildCategoriesView() {
    final categories = [
      _CategoryItem(
        name: 'Academic',
        icon: Icons.school,
        color: AppColors.primaryBlue,
        count: 12,
      ),
      _CategoryItem(
        name: 'Social',
        icon: Icons.people,
        color: Colors.purple,
        count: 8,
      ),
      _CategoryItem(
        name: 'Sports',
        icon: Icons.sports_basketball,
        color: Colors.orange,
        count: 5,
      ),
      _CategoryItem(
        name: 'Arts & Culture',
        icon: Icons.palette,
        color: Colors.pink,
        count: 9,
      ),
      _CategoryItem(
        name: 'Career',
        icon: Icons.work,
        color: Colors.green,
        count: 6,
      ),
      _CategoryItem(
        name: 'Health & Wellness',
        icon: Icons.favorite,
        color: Colors.red,
        count: 4,
      ),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(category.icon, size: 40, color: category.color),
                  const SizedBox(height: 12),
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${category.count} Events',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventCard(_EventItem event) {
    return Card(
      elevation: event.isHighlighted ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            event.isHighlighted
                ? BorderSide(color: AppColors.primaryBlue, width: 2)
                : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date container
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          event.isHighlighted
                              ? AppColors.primaryBlue
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          event.date.split(' ')[0], // Month
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                event.isHighlighted
                                    ? Colors.white
                                    : AppColors.primaryBlue,
                          ),
                        ),
                        Text(
                          event.date.split(' ')[1].replaceAll(',', ''), // Day
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                event.isHighlighted
                                    ? Colors.white
                                    : AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Event details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                event.isHighlighted
                                    ? AppColors.primaryBlue
                                    : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(
                              event.category,
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            event.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCategoryColor(event.category),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.access_time, event.time),
                        const SizedBox(height: 4),
                        _buildInfoRow(Icons.location_on, event.location),
                      ],
                    ),
                  ),
                ],
              ),
              if (event.isHighlighted) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today, size: 16),
                      label: const Text('Add to Calendar'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        side: BorderSide(color: AppColors.primaryBlue),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, size: 16),
                      label: const Text('Share'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        side: BorderSide(color: AppColors.primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Academic':
        return AppColors.primaryBlue;
      case 'Social':
        return Colors.purple;
      case 'Sports':
        return Colors.orange;
      case 'Arts & Culture':
        return Colors.pink;
      case 'Career':
        return Colors.green;
      case 'Health & Wellness':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String text;

  const _WeekdayLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
          fontSize: 12,
        ),
      ),
    );
  }
}

class _EventItem {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String category;
  final bool isHighlighted;

  _EventItem({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.category,
    required this.isHighlighted,
  });
}

class _CategoryItem {
  final String name;
  final IconData icon;
  final Color color;
  final int count;

  _CategoryItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.count,
  });
}
