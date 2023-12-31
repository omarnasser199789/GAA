import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/cart_repository.dart';


///The [AddProductInLocalDBUseCase] class implements the [UseCase] interface, which likely defines a common set of methods or properties that all use cases in the application must implement.
/// The repository property is an instance of a [MyCartRepository], which is likely an abstraction over the local database.
///
/// The [call] method is the main method of the use case, which takes an instance of [AddProductParams] as input and returns a [Future] that resolves to either a [Failure] or an int.
/// The [AddProductParams] likely contains information about the product that needs to be added to the database.
///
/// The implementation of the [call] method simply delegates the responsibility of adding the product to the [repository] instance by calling its [addProduct] method with the params as input.
/// The [addProduct] method likely performs the actual database interaction and returns a [Future] that resolves to either a [Failure] or an [int] depending on whether the operation was successful or not.
///
/// Overall, this code appears to be a simple and straightforward implementation of a use case responsible for adding a product to a local database.

class AddProductInLocalDBUseCase implements UseCase< int, AddProductParams> {
  final MyCartRepository repository;
  AddProductInLocalDBUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(AddProductParams params) {

    return repository.addProduct(params);
  }
}

///The class contains several properties that represent different attributes of the product, such as [apiId], [productType], [name], [image], [trainer], [newPrice], [oldPrice], and [fav].
/// These properties are all marked as [required], meaning they must be provided when an instance of the class is created.
///
/// The class also contains a [toMap] method, which converts an instance of [AddProductParams] to a Map<String, dynamic> object that can be used to insert the product into a database.
/// The keys in the map correspond to the names of the columns in the database, and the values correspond to the values of the properties in the AddProductParams instance.
///
/// Lastly, the class defines a [toString] method that returns a string representation of the [AddProductParams] instance.
/// This method can be useful for debugging and printing out the values of the properties in a human-readable format.
///
/// Overall, this code defines a simple data class that encapsulates the parameters required to add a product to a local database.
/// The [toMap] method provides a convenient way to convert the instance to a map that can be used to insert the product into the database.

class AddProductParams{
  final int apiId;
  final int productType;
  final String name;
  final String image;
  final String trainer;
  final double newPrice;
  final double oldPrice;
  final int  fav;


  const AddProductParams({
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