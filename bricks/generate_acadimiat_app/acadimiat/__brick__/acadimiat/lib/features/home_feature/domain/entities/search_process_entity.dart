import 'package:equatable/equatable.dart';

class SearchProcessEntity extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
  SearchProcessEntity({
    required this.id,
    required this.text,
  });

 final int id;
 final String text;
}