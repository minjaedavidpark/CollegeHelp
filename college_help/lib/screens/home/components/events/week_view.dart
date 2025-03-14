import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class WeekView extends StatelessWidget {
  final DateTime selectedDate;
  final List<DateTime> datesWithEvents;
  final Function(DateTime) onDateSelected;

  const WeekView({
    super.key,
    required this.selectedDate,
    required this.datesWithEvents,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final weekDays = _getWeekDays();

    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekDays.length,
        itemBuilder: (context, index) {
          final date = weekDays[index];
          final isSelected = _isSameDay(date, selectedDate);
          final isToday = _isSameDay(date, DateTime.now());
          final hasEvents = datesWithEvents.any((d) => _isSameDay(d, date));

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.primaryBlue
                        : isToday
                        ? AppColors.primaryBlue.withOpacity(0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Weekday (Mon, Tue, etc.)
                  Text(
                    _getDayOfWeek(date),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? Colors.white.withOpacity(0.8)
                              : AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Day of month
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? Colors.white
                              : isToday
                              ? AppColors.primaryBlue
                              : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Event indicator
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          hasEvents
                              ? isSelected
                                  ? Colors.white
                                  : AppColors.secondaryRed
                              : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<DateTime> _getWeekDays() {
    // Get the date for Monday of the current week
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

    // Return 7 days starting from Monday
    return List.generate(
      7,
      (index) => DateTime(
        firstDayOfWeek.year,
        firstDayOfWeek.month,
        firstDayOfWeek.day + index,
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    // Weekday is 1-7 where 1 is Monday and 7 is Sunday
    // Adjust to match the array index (0-6)
    int index = date.weekday - 1;
    return weekdays[index];
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
