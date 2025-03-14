import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class MonthCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime currentMonth;
  final List<DateTime> datesWithEvents;
  final Function(DateTime) onDateSelected;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthCalendar({
    super.key,
    required this.selectedDate,
    required this.currentMonth,
    required this.datesWithEvents,
    required this.onDateSelected,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month navigation header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: onPreviousMonth,
            ),
            Text(
              _getMonthYearText(currentMonth),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: onNextMonth,
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (String day in ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
              SizedBox(
                width: 40,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLight,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: _getDaysInMonthWithPadding().length,
          itemBuilder: (context, index) {
            final date = _getDaysInMonthWithPadding()[index];
            // If the date is null, it's a padding day outside the current month
            if (date == null) {
              return const SizedBox();
            }

            final isSelected = _isSameDay(date, selectedDate);
            final isToday = _isSameDay(date, DateTime.now());
            final hasEvents = datesWithEvents.any((d) => _isSameDay(d, date));
            final isCurrentMonth = date.month == currentMonth.month;

            return GestureDetector(
              onTap: () {
                if (isCurrentMonth) {
                  onDateSelected(date);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppColors.primaryBlue
                          : isToday
                          ? AppColors.primaryBlue.withOpacity(0.1)
                          : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected || isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                        color:
                            isSelected
                                ? Colors.white
                                : !isCurrentMonth
                                ? Colors.grey.withOpacity(0.3)
                                : AppColors.textDark,
                      ),
                    ),
                    if (hasEvents && !isSelected)
                      Positioned(
                        bottom: 8,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.white
                                    : AppColors.secondaryRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _getMonthYearText(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  List<DateTime?> _getDaysInMonthWithPadding() {
    final result = <DateTime?>[];

    // First day of the month
    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);

    // Number of days in the month
    final daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

    // Add padding for days before the first day of the month
    final firstDayWeekday = firstDay.weekday;
    final paddingDays = firstDayWeekday == 7 ? 0 : firstDayWeekday;
    for (int i = 0; i < paddingDays; i++) {
      result.add(null);
    }

    // Add all days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      result.add(DateTime(currentMonth.year, currentMonth.month, i));
    }

    // Add padding for days after the last day of the month to complete the grid
    final remainingDays = (7 - (result.length % 7)) % 7;
    for (int i = 0; i < remainingDays; i++) {
      result.add(null);
    }

    return result;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
