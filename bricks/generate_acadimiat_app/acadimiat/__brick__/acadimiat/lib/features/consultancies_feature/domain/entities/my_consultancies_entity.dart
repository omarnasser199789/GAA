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

 final int id;
 final String consultancy;
 final String consultancyImage;
 final String consultant;
 final String email;
 final String phone;
 final DateTime date;
 final int numberOfSessions;
}