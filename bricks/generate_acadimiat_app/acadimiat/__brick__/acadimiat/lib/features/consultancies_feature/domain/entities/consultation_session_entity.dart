import 'package:equatable/equatable.dart';
class ConsultationSessionEntity extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
  ConsultationSessionEntity({
    required  this.meetingId,
    required  this.timezone,
    required  this.consultancyTimezone,
    required  this.id,
    required  this.date,
    required  this.hour,
    required  this.isActive,
    required  this.isDone,
    required  this.day,
    required  this.url,
    required  this.meetingLongId,
    required  this.attendeePw,
  });

 final String meetingId;
 final String timezone;
 final String consultancyTimezone;
 final int id;
 final DateTime date;
 final DateTime hour;
 final bool isActive;
 final bool isDone;
 final String day;
 final String url;
 final dynamic meetingLongId;
 final dynamic attendeePw;
}