
import 'package:equatable/equatable.dart';
class BannersEntity extends Equatable{

  BannersEntity({
    required this.id,
    this.courseId,
    this.packageId,
    this.consultancyId,
    this.articleId,
    required this.linkUrl,
    required this.type,
    required this.order,
    required this.header,
    required this.imageUrl,
    required this.videoUrl,
    required this.body,
    required this.subtitle,
  });

  int id;
  int? courseId;
  dynamic packageId;
  dynamic consultancyId;
  dynamic articleId;
  String linkUrl;
  int type;
  int order;
  String header;
  String imageUrl;
  String videoUrl;
  String body;
  String subtitle;
  
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}