import 'package:equatable/equatable.dart';
class CheckPasswordEntity extends Equatable{
  CheckPasswordEntity({
    required this.result,
  });

  final String result;
  @override
  List<Object?> get props => throw UnimplementedError();

}