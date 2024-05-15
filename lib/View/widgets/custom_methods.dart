import 'package:flutter/material.dart';

int getDaysInMonth(DateTime monthofYear) {
  return DateUtils.getDaysInMonth(
    monthofYear.year,
    monthofYear.month,
  );
}
