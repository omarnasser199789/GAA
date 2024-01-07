
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

 final int id;
 final int? courseId;
 final dynamic packageId;
 final dynamic consultancyId;
 final dynamic articleId;
 final String linkUrl;
 final int type;
 final int order;
 final String header;
 final String imageUrl;
 final String videoUrl;
 final String body;
 final String subtitle;
  
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}