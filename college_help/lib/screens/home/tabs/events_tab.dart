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
  final List<DateTime> _datesWithEvents = [];

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

    // Add dates with events
    for (int i = -5; i < 30; i += 2) {
      if (i != 0) {
        // Skip today to ensure we're not adding it twice
        _datesWithEvents.add(now.add(Duration(days: i)));
      }
    }
    // Always add today
    _datesWithEvents.add(now);

    // Add March 19, 2025 (the selected date in the screenshot)
    final march192025 = DateTime(2025, 3, 19);
    _datesWithEvents.add(march192025);

    // Upcoming events
    _allEvents.addAll([
      _EventItem(
        title: 'Welcome Week Gala',
        date: DateFormat(
          'MMM d, yyyy',
        ).format(now.add(const Duration(days: 2))),
        time: '7:00 PM - 10:00 PM',
        location: 'Wilson Hall Auditorium',
        description:
            'Join us for an evening of celebration, food, and entertainment as we welcome new and returning students to New College.',
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
        date: DateFormat('MMM d, yyyy').format(now),
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
      // Add more events for March 19, 2025 to test scrolling
      _EventItem(
        title: 'Intramural Basketball Signup',
        date: DateFormat('MMM d, yyyy').format(march192025),
        time: '10:00 AM - 4:00 PM',
        location: 'Athletic Center, Room 202',
        description:
            'Sign up for the fall intramural basketball league. All skill levels welcome! Teams of 5-7 players.',
        category: 'Sports',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Campus Tour for Prospective Students',
        date: DateFormat('MMM d, yyyy').format(march192025),
        time: '11:30 AM - 1:00 PM',
        location: 'Admissions Office, Main Building',
        description:
            'Join us for a guided tour of the campus for prospective students and their families. Learn about our facilities, programs, and student life.',
        category: 'Academic',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Research Symposium Preparation',
        date: DateFormat('MMM d, yyyy').format(march192025),
        time: '1:30 PM - 3:00 PM',
        location: 'Science Building, Room 305',
        description:
            'Workshop for students presenting at the upcoming research symposium. Get feedback on your presentation and tips for effective communication.',
        category: 'Academic',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Student Government Meeting',
        date: DateFormat('MMM d, yyyy').format(march192025),
        time: '3:30 PM - 5:00 PM',
        location: 'Student Union, Conference Room A',
        description:
            'Weekly meeting of the Student Government Association. Open to all students interested in campus governance and policy.',
        category: 'Academic',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Meditation Workshop',
        date: DateFormat('MMM d, yyyy').format(march192025),
        time: '5:30 PM - 6:30 PM',
        location: 'Wellness Center, Room 102',
        description:
            'Learn mindfulness techniques to reduce stress and improve focus. No prior experience necessary. Mats and cushions provided.',
        category: 'Health & Wellness',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Film Screening: "The Graduate"',
        date: DateFormat('MMM d, yyyy').format(march192025),
        time: '7:00 PM - 9:30 PM',
        location: 'Media Center, Auditorium',
        description:
            'Classic film screening followed by a discussion led by Professor Johnson from the Film Studies department. Refreshments provided.',
        category: 'Arts & Culture',
        isHighlighted: false,
      ),
      _EventItem(
        title: 'Astronomy Night',
        date: DateFormat('MMM d, yyyy').format(march192025),
        time: '9:00 PM - 11:00 PM',
        location: 'Observatory, Science Building Roof',
        description:
            'Join the Astronomy Club for stargazing and planet viewing through the university telescope. Hot chocolate and snacks provided.',
        category: 'Academic',
        isHighlighted: false,
      ),
    ]);
  }

  // Get events for a specific date
  List<_EventItem> _getEventsForDate(DateTime date) {
    try {
      return _allEvents.where((event) {
        try {
          final eventDate = DateFormat('MMM d, yyyy').parse(event.date);
          return eventDate.year == date.year &&
              eventDate.month == date.month &&
              eventDate.day == date.day;
        } catch (e) {
          return false;
        }
      }).toList();
    } catch (e) {
      return [];
    }
  }

  bool _doesDateHaveEvents(DateTime date) {
    return _datesWithEvents.any(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
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
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
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
    // Sort events by date
    final sortedEvents = List<_EventItem>.from(_allEvents);
    sortedEvents.sort((a, b) {
      try {
        final dateA = DateFormat('MMM d, yyyy').parse(a.date);
        final dateB = DateFormat('MMM d, yyyy').parse(b.date);
        return dateA.compareTo(dateB);
      } catch (e) {
        return 0;
      }
    });

    // Group events by date for better visual organization
    final groupedEvents = <String, List<_EventItem>>{};
    for (var event in sortedEvents) {
      if (groupedEvents.containsKey(event.date)) {
        groupedEvents[event.date]!.add(event);
      } else {
        groupedEvents[event.date] = [event];
      }
    }

    // Create a list of date strings sorted chronologically
    final sortedDates = groupedEvents.keys.toList();
    sortedDates.sort((a, b) {
      try {
        final dateA = DateFormat('MMM d, yyyy').parse(a);
        final dateB = DateFormat('MMM d, yyyy').parse(b);
        return dateA.compareTo(dateB);
      } catch (e) {
        return 0;
      }
    });

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedDates.length,
      itemBuilder: (context, dateIndex) {
        final date = sortedDates[dateIndex];
        final events = groupedEvents[date]!;

        // Parse the date for comparisons
        DateTime parsedDate;
        try {
          parsedDate = DateFormat('MMM d, yyyy').parse(date);
        } catch (e) {
          parsedDate = DateTime.now();
        }

        // Check if this is today or a future date
        final now = DateTime.now();
        final isToday =
            parsedDate.year == now.year &&
            parsedDate.month == now.month &&
            parsedDate.day == now.day;

        // Format the date header
        String dateHeader;
        if (isToday) {
          dateHeader = "Today - ${DateFormat('MMM d').format(parsedDate)}";
        } else if (parsedDate.difference(now).inDays == 1) {
          dateHeader = "Tomorrow - ${DateFormat('MMM d').format(parsedDate)}";
        } else {
          dateHeader = DateFormat('EEEE, MMM d').format(parsedDate);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header with indicator for today
            Container(
              margin: EdgeInsets.only(top: dateIndex > 0 ? 24 : 0, bottom: 8),
              child: Row(
                children: [
                  if (isToday)
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(
                    dateHeader,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isToday ? AppColors.primaryBlue : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            // Events for this date
            ...events
                .map(
                  (event) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildImprovedEventCard(event),
                  ),
                )
                .toList(),
          ],
        );
      },
    );
  }

  Widget _buildImprovedEventCard(_EventItem event) {
    final bool isHighlighted = event.isHighlighted;

    return Card(
      elevation: isHighlighted ? 2 : 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isHighlighted
                ? BorderSide(color: AppColors.primaryBlue, width: 1.5)
                : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time column
                  Container(
                    width: 50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isHighlighted
                              ? AppColors.primaryBlue.withOpacity(0.1)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          event.time.split(' - ')[0],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                isHighlighted
                                    ? AppColors.primaryBlue
                                    : Colors.grey[800],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Event details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isHighlighted
                                              ? AppColors.primaryBlue
                                              : Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
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
                                        fontSize: 11,
                                        color: _getCategoryColor(
                                          event.category,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.time,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.location,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isHighlighted) ...[
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today, size: 14),
                      label: const Text('Add', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        minimumSize: const Size(10, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, size: 14),
                      label: const Text(
                        'Share',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        minimumSize: const Size(10, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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

  Widget _buildCalendarView() {
    return Column(
      children: [
        // Calendar header section
        Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Month navigation
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
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
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 24,
                      splashRadius: 20,
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
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 24,
                      splashRadius: 20,
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
              SizedBox(
                height: 280, // Fixed height calendar
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: _getDaysInMonthWithPadding().length,
                  itemBuilder: (context, index) {
                    final days = _getDaysInMonthWithPadding();
                    if (index >= days.length) return const SizedBox();

                    final day = days[index];

                    // Check if this date has events
                    final hasEvents = day != null && _doesDateHaveEvents(day);

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

              // Add extra padding at the bottom of the calendar to prevent overlap
              const SizedBox(height: 16),
            ],
          ),
        ),

        const Divider(height: 1),

        // Events for selected date
        Expanded(child: _buildEventsForSelectedDate()),
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
            mainAxisSize: MainAxisSize.min,
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
                          ? Colors.grey.withOpacity(0.4)
                          : Colors.black87,
                  fontSize: 13,
                ),
              ),
              if (hasEvents)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  width: 4,
                  height: 4,
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

    // Format date for header
    final formattedDate = DateFormat(
      'EEEE, MMMM d, yyyy',
    ).format(_selectedDate);
    final isToday =
        _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;

    return Column(
      children: [
        // Date header with extra padding to prevent overlap with calendar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          margin: const EdgeInsets.only(
            top: 8.0,
          ), // Extra margin to push down from calendar
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.event, color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isToday ? 'Today, $formattedDate' : formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        // Events list
        Expanded(
          child:
              eventsForDate.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No events on this date',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Select a different date or check back later',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: eventsForDate.length,
                    itemBuilder: (context, index) {
                      if (index >= eventsForDate.length)
                        return const SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildCompactEventCard(eventsForDate[index]),
                      );
                    },
                  ),
        ),
      ],
    );
  }

  // Compact event card for calendar view
  Widget _buildCompactEventCard(_EventItem event) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Category indicator
              Container(
                width: 4,
                height: 42,
                decoration: BoxDecoration(
                  color: _getCategoryColor(event.category),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              // Time
              SizedBox(
                width: 50,
                child: Text(
                  event.time.split(' - ')[0],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Event details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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

  List<DateTime?> _getDaysInMonthWithPadding() {
    final List<DateTime?> days = [];

    try {
      // First day of the month
      final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);

      // Last day of the month
      final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

      // Add padding for days before the first day of the month
      // This converts Sunday=0 to Sunday=6 for proper display
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
    } catch (e) {
      print('Error generating calendar days: $e');
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
}

class _WeekdayLabel extends StatelessWidget {
  final String text;

  const _WeekdayLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
          fontSize: 11,
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
