
import 'package:equatable/equatable.dart';
class SearchProcessEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  SearchProcessEntity({
    required this.id,
    required this.text,
  });

  int id;
  String text;
}