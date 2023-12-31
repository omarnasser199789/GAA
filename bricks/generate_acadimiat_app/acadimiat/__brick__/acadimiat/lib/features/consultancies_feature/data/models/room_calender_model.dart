// To parse this JSON data, do
//
//     final roomCalendarModel = roomCalendarModelFromJson(jsonString);

import 'dart:convert';

List<int> roomCalendarModelFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

String roomCalendarModelToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
