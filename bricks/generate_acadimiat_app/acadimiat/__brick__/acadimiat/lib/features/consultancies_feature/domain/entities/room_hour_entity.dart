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

  double startFrom;
  double endAt;
  bool active;
}