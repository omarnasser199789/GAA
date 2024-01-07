
import 'package:equatable/equatable.dart';
import '../../data/models/card_by_id_model.dart';

class CardByIdEntity extends Equatable{
 final int id;
 final String courseName;
 final String appleId;
 final String googleId;
 final String trainerName;
 final String courseDescription;
 final double mainPrice;
 final double currentPrice;
 final dynamic courseLink;
 final dynamic courseKeywords;
 final String courseCover;
 final String courseVideo;
 final String courseCertificateSample;
 final int numberOfUnites;
 final int numberOfLectures;
 final int videosLength;
 final List<Trainer> trainers;
 final dynamic coursePrices;
 final List<CourseUnit> courseUnits;
 final List<CourseInfo> courseInfo;
 final dynamic quizz;

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