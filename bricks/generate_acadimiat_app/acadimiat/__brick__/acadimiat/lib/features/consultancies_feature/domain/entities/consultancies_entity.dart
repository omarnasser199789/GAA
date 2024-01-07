import 'package:equatable/equatable.dart';

class ConsultanciesEntity extends Equatable{

 final int consultancyId;
 final String name;
 final dynamic body;
 final String image;
 final String consultantName;
 final int numberOfSessions;
 final dynamic subscriptionLimit;
 final dynamic typeOfSession;
 final dynamic squareImage;
 final String consultantImage;
 final String consultantInfo;
 final int consultantId;
 final double consultancyPrice;
 final double timeLimit;
 final dynamic info;

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