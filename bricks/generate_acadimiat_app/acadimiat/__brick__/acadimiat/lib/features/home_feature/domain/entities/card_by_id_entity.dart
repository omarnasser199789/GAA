
import 'package:equatable/equatable.dart';
import '../../data/models/card_by_id_model.dart';

class CardByIdEntity extends Equatable{
  int id;
  String courseName;
  String appleId;
  String googleId;
  String trainerName;
  String courseDescription;
  double mainPrice;
  double currentPrice;
  dynamic courseLink;
  dynamic courseKeywords;
  String courseCover;
  String courseVideo;
  String courseCertificateSample;
  int numberOfUnites;
  int numberOfLectures;
  int videosLength;
  List<Trainer> trainers;
  dynamic coursePrices;
  List<CourseUnit> courseUnits;
  List<CourseInfo> courseInfo;
  dynamic quizz;

  CardByIdEntity(
  {
  required this.id,
  required this.courseName,
  required this.appleId,
  required this.googleId,
  required this.trainerName,
  required this.courseDescription,
  required this.mainPrice,
  required this.currentPrice,
  required this.courseLink,
  required this.courseKeywords,
  required this.courseCover,
  required this.courseVideo,
  required this.courseCertificateSample,
  required this.numberOfUnites,
  required this.numberOfLectures,
  required this.videosLength,
  required this.trainers,
  required this.coursePrices,
  required this.courseUnits,
  required this.courseInfo,
    required this.quizz,







}
      );

  @override
  // TODO: implement props
  List<Object> get props => [id,courseName,trainerName,courseDescription,mainPrice,
  currentPrice,courseLink,courseKeywords,courseCover,courseVideo,courseCertificateSample,
  numberOfLectures,numberOfUnites,videosLength,trainers,coursePrices,courseUnits,courseInfo];

}