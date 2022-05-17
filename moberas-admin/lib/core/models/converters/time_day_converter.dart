import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    return TimeOfDay.fromDateTime(DateTime.parse(json));
  }

  @override
  String toJson(TimeOfDay json) => DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, json.hour, json.minute)
      .toIso8601String();
}
