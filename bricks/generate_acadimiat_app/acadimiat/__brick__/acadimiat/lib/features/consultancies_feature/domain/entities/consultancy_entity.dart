import 'package:equatable/equatable.dart';

import '../../data/models/consultancy_model.dart';

class ConsultancyEntity extends Equatable{


  ConsultancyEntity({
    required  this.consultancyId,
    required  this.name,
    required  this.body,
    required  this.image,
    required  this.consultantName,
    required  this.numberOfSessions,
    required  this.subscriptionLimit,
    required  this.typeOfSession,
    required  this.squareImage,
    required  this.consultantImage,
    required  this.consultantInfo,
    required  this.consultantId,
    required  this.consultancyPrice,
    required  this.timeLimit,
    required  this.info,
  });

  int consultancyId;
  String name;
  dynamic body;
  String image;
  String consultantName;
  int numberOfSessions;
  String subscriptionLimit;
  String typeOfSession;
  dynamic squareImage;
  String consultantImage;
  String consultantInfo;
  int consultantId;
  double consultancyPrice;
  double timeLimit;
  List<Info> info;


  @override
  // TODO: implement props
  List<Object> get props => [consultancyId,name,body,image,consultantName,
    numberOfSessions,subscriptionLimit,typeOfSession,squareImage,consultantImage,consultantInfo,
    consultantId,consultancyPrice,timeLimit,info];
}