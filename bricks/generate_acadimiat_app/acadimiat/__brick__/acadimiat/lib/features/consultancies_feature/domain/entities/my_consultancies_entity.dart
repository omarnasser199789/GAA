import 'package:equatable/equatable.dart';
class MyConsultanciesEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  MyConsultanciesEntity({
    required this.id,
    required this.consultancy,
    required this.consultancyImage,
    required this.consultant,
    required this.email,
    required this.phone,
    required this.date,
    required this.numberOfSessions,
  });

  int id;
  String consultancy;
  String consultancyImage;
  String consultant;
  String email;
  String phone;
  DateTime date;
  int numberOfSessions;
}