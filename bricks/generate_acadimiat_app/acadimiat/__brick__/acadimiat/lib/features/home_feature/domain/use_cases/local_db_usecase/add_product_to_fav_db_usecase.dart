import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';





class AddProductToFavLocalDBUseCase implements UseCase<int,AddProductToFavParams> {
  final HomeRepository repository;
  AddProductToFavLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(AddProductToFavParams params) {
    print("step1");
    return repository.addProductToFav(params);
  }
}


class AddProductToFavParams{
  final int apiId;
  final int productType;
  final String name;
  final String image;
  final String trainer;
  final double newPrice;
  final double oldPrice;
  final int  fav;


  const AddProductToFavParams({
    required this.apiId,
    required this.productType,
    required this.name,
    required this.trainer,
    required this.newPrice,
    required this.oldPrice,
    required this.image,
    required this.fav
  });

  // Convert a DogModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {

      'apiId': apiId,
      'productType': productType,
      'name': name,
      'trainer': trainer,
      'newPrice': newPrice,
      'oldPrice': oldPrice,
      'fav': fav,
      'image': image,

    };
  }

  // Implement toString to make it easier to see information about
  // each DogModel when using the print statement.
  @override
  String toString() {
    return 'product{apiId:$apiId,productType:$productType, name: $name, image: $image ,trainer: $trainer , newPrice:$newPrice ,oldPrice:$oldPrice, fav:$fav}';
  }
}



