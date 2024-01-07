import 'package:acadmiat/features/cart_feature/presentation/bloc/success_error/either_success_or_error.dart';
import '../../domain/use_cases/add_product_in_local_db_usecase.dart';
import '../../domain/use_cases/apply_coupon_to_cart_usecase.dart';
import '../../domain/use_cases/check_if_product_is_exit_in_db_usecase.dart';
import '../../domain/use_cases/delete _product_from_locale_db_usecase.dart';
import '../../domain/use_cases/delete_all_products_from_cart_usecase.dart';
import '../../domain/use_cases/enable_courses_usecase.dart';
import '../../domain/use_cases/get_all_products_from_local_db_usecase.dart';
import '../../domain/use_cases/payment_usecase.dart';
import 'bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {

  final AddProductInLocalDBUseCase addProductInLocalDBUseCase;
  final GetAllProductsFromLocalDBUseCase getAllProductsFromLocalDBUseCase;
  final DeleteProductFromLocalDBUseCase deleteProductFromLocalDBUseCase;
  final ApplyCouponToCartUseCase applyCouponToCartUseCase;
  final CheckIfProductIsExitInDBUseCase checkIfProductIsExitInDBUseCase;
  final DeleteAllProductFromLocalDBUseCase deleteAllProductFromLocalDBUseCase;
  final PaymentUseCase paymentUseCase;
  final EnableCoursesUseCase enableCoursesUseCase;

  MyCartBloc({
    required AddProductInLocalDBUseCase concreteAddProductInLocalDBUseCase,
    required CheckIfProductIsExitInDBUseCase concreteCheckIfProductIsExitInDBUseCase,
    required GetAllProductsFromLocalDBUseCase concreteGetAllProductsFromLocalDBUseCase,
    required DeleteProductFromLocalDBUseCase concreteDeleteProductFromLocalDBUseCase,
    required ApplyCouponToCartUseCase concreteApplyCouponToCartUseCase,
    required DeleteAllProductFromLocalDBUseCase concreteDeleteAllProductFromLocalDBUseCasee,
    required PaymentUseCase concretePaymentUseCase,
    required EnableCoursesUseCase concreteEnableCoursesUseCase,
  })  : checkIfProductIsExitInDBUseCase = concreteCheckIfProductIsExitInDBUseCase,
        addProductInLocalDBUseCase = concreteAddProductInLocalDBUseCase,
        getAllProductsFromLocalDBUseCase = concreteGetAllProductsFromLocalDBUseCase,
        deleteProductFromLocalDBUseCase = concreteDeleteProductFromLocalDBUseCase,
        applyCouponToCartUseCase = concreteApplyCouponToCartUseCase,
        deleteAllProductFromLocalDBUseCase = concreteDeleteAllProductFromLocalDBUseCasee,
        paymentUseCase = concretePaymentUseCase,
        enableCoursesUseCase = concreteEnableCoursesUseCase,
        super(Empty());

  @override
   Stream<MyCartState> mapEventToState(MyCartEvent event) async* {

    if(event is AddProductToCart){
        await addProductInLocalDBUseCase(event.params);
    }
    if(event is GetAllProductsFromCart){
      yield Loading();
      final failureOrPhysician =  await getAllProductsFromLocalDBUseCase("");
      yield* cartEntityLoadedOrErrorState(failureOrPhysician);
    }
    if(event is DeleteProductToCart){
      yield Loading();
      final failureOrPhysician =  await deleteProductFromLocalDBUseCase(event.id);
      yield* productDeleteFromCartOrErrorState(failureOrPhysician);
    }
    if(event is DeleteAllProductsFromCart){
      final failureOrPhysician =  await deleteAllProductFromLocalDBUseCase("");
      yield* productDeleteFromCartOrErrorState(failureOrPhysician);
    }
    if(event is ApplyCouponEvent){
      yield Loading();
      final failureOrPhysician =  await applyCouponToCartUseCase(event.applyCouponParams);
      yield* successApplyCouponOrErrorState(failureOrPhysician);
    }
    if(event is CheckIfProductIsExitEvent){
      yield Loading();
      final failureOrPhysician =  await checkIfProductIsExitInDBUseCase(event.id);
      yield* successCheckIfProductIsExitOrErrorState(failureOrPhysician);
    }
    if(event is RestartEvent){
      yield Empty();
    }
    if(event is EnableCoursesEvent){
      yield Loading();
      final failureOrPhysician =  await  enableCoursesUseCase(event.params);
      yield* successEnableCoursesOrErrorState(failureOrPhysician);
    }
  }
}
