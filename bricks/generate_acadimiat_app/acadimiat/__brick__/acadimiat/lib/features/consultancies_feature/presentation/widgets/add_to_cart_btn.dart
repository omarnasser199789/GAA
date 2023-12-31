// import 'package:acadmiat/injection_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../Locale/locale.dart';
// import '../../../../core/classes/constants.dart';
// import '../../../../core/widgets/custom_botton.dart';
// import '../../../cart_feature/domain/use_cases/add_product_in_local_db_usecase.dart';
// import '../../../cart_feature/presentation/bloc/my_cart_bloc.dart';
// import '../../../cart_feature/presentation/bloc/my_cart_state.dart';
// import '../../../cart_feature/presentation/bloc/my_courses_event.dart';
// import '../../domain/entities/consultancy_entity.dart';
//
//
// class AddToCartBtn extends StatelessWidget {
//    AddToCartBtn({Key? key,required this.consultancyEntity}) : super(key: key);
//   final ConsultancyEntity consultancyEntity;
//   bool allowGoToCart=false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     Size size = MediaQuery.of(context).size;
//     return   BlocProvider(
//         create: (BuildContext context) => sl<MyCartBloc>(),
//         child: BlocBuilder<MyCartBloc,MyCartState>(
//             builder: (context, state) {
//               if (state is SuccessCheckProductEntity) {
//                 if(state.statusCode==200){
//
//                 }
//                 else if(state.statusCode == 404){
//                   BlocProvider.of<MyCartBloc>(context)
//                       .add(AddProductToCart(
//                       params: AddProductParams(
//                         name: consultancyEntity.name,
//                         apiId: consultancyEntity.consultancyId,
//                         trainer: consultancyEntity.consultantName,
//                         newPrice:0,
//                         oldPrice:consultancyEntity.consultancyPrice,
//                         fav: 0,
//                         image: consultancyEntity.consultantImage,
//                         productType: ProductType.consultant,
//                       )));
//                 }
//                 if(allowGoToCart){
//                   allowGoToCart=false;
//                   Future.delayed(const Duration(milliseconds: 500), () {
//                     // goTo(context, (context) => const CartPage());
//                   });
//                 }
//
//
//               }
//
//               return CustomButton(
//                 width: size.width - 34,
//                       title: locale.buyNow! +
//                           "   ${consultancyEntity.consultancyPrice.toInt()}\$",
//                 onTap: () {
//                   allowGoToCart=true;
//
//                   ///Check if product exit already in (cart)DB or not.
//                   BlocProvider.of<MyCartBloc>(context).add(
//                       CheckIfProductIsExitEvent(
//                           id: consultancyEntity.consultancyId));
//                 },
//               );
//             }));
//
//   }
// }
