import 'package:equatable/equatable.dart';

import '../../data/models/files_model.dart';

class FilesEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  FilesEntity({
    required  this.index,
    required  this.items,
  });

  int index;
  List<Item> items;

}