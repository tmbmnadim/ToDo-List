import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

NotifierProvider<DateTimeState, DateTime> dateState =
    NotifierProvider<DateTimeState, DateTime>(() => DateTimeState());

class DateTimeState extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void changeDate(DateTime date) {
    state = date;
  }

  void nextMonth() {
    int daysInMonth = DateUtils.getDaysInMonth(state.year, state.month);
    int daysLeftInMonth = daysInMonth - state.day;
    state = state.add(Duration(days: daysLeftInMonth + 1));
  }

  void previousMonth() {
    state = state.subtract(Duration(days: state.day + 1));
  }

  void nextDay() {
    state = state.add(const Duration(days: 1));
  }

  void selectDay(int selectDay) {
    state = state.copyWith(day: selectDay);
  }

  void previousDay() {
    state = state.subtract(const Duration(days: 1));
  }
}
