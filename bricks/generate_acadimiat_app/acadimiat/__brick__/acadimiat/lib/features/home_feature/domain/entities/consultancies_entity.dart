import 'package:equatable/equatable.dart';

class ConsultanciesEntity extends Equatable{

  int consultancyId;
  String name;
  dynamic body;
  String image;
  String consultantName;
  int numberOfSessions;
  dynamic subscriptionLimit;
  dynamic typeOfSession;
  dynamic squareImage;
  String consultantImage;
  String consultantInfo;
  int consultantId;
  double consultancyPrice;
  double timeLimit;
  dynamic info;

  ConsultanciesEntity({
    required this.consultancyId,
    required this.name,
    required this.body,
    required this.image,
    required this.consultantName,
    required this.numberOfSessions,
    required this.subscriptionLimit,
    required this.typeOfSession,
    required this.squareImage,
    required this.consultantImage,
    required this.consultantInfo,
    required this.consultantId,
    required this.consultancyPrice,
    required this.timeLimit,
    required this.info,


  });


  @override
  List<Object> get props => [consultancyId,name,body,image,consultantName,
    numberOfSessions,subscriptionLimit,typeOfSession,squareImage,consultantImage,consultantId,
    consultancyPrice,timeLimit,info];

}