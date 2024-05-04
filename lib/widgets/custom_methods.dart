import 'package:flutter/material.dart';

List<String> getDaysInMonth(DateTime monthofYear) {
  return List.generate(
    DateUtils.getDaysInMonth(
      monthofYear.year,
      monthofYear.month,
    ),
    (index) => "${index + 1}",
  );
}
