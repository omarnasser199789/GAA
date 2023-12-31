
import 'package:equatable/equatable.dart';
 class  ReserveMeetingEntity extends Equatable{
  ReserveMeetingEntity({
    required this.meetingId,
    required this.timezone,
    required this.consultancyTimezone,
    required this.id,
    required this.date,
    required this.hour,
    required this.isActive,
    required this.isDone,
    required this.day,
    required this.url,
    required this.meetingLongId,
    required this.attendeePw,
  });

  String meetingId;
  String timezone;
  String consultancyTimezone;
  int id;
  DateTime date;
  DateTime hour;
  bool isActive;
  bool isDone;
  String day;
  String url;
  dynamic meetingLongId;
  dynamic attendeePw;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}