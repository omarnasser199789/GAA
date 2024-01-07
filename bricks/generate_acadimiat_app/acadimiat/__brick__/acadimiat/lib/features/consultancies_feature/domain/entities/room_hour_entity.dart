import 'package:equatable/equatable.dart';

class RoomHourEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  RoomHourEntity({
    required  this.startFrom,
    required  this.endAt,
    required  this.active,
  });

 final double startFrom;
 final double endAt;
 final bool active;
}