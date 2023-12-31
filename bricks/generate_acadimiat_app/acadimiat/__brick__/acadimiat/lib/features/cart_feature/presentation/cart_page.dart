// import 'package:acadmiat/core/globals.dart';
// import 'package:acadmiat/features/cart_feature/domain/use_cases/enable_courses_usecase.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../../../Locale/locale.dart';
// import '../../../Theme/style.dart';
// import '../../../core/classes/constants.dart';
// import '../../../core/functions.dart';
// import '../../../core/widgets/app_bar_widget.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/widgets/cached_net_work_image.dart';
// import '../../../core/widgets/custom_botton.dart';
// import '../../../core/widgets/custom_text_field.dart';
// import '../../../core/widgets/empty_state_widget.dart';
// import '../../../core/widgets/payment_button.dart';
// import '../../../core/widgets/price_widget.dart';
// import '../../../injection_container.dart';
// import '../../consultancies_feature/presentation/pages/consultation_by_id.dart';
// import '../../home_feature/presentation/pages/course_content_page.dart';
// import '../../home_feature/presentation/pages/courses_content_page.dart';
// import '../../home_feature/presentation/widgets/cart_change_notifier.dart';
// import '../domain/entities/apply_coupon_entity.dart';
// import '../domain/entities/files_entity.dart';
// import '../domain/use_cases/apply_coupon_to_cart_usecase.dart';
// import 'bloc/my_cart_bloc.dart';
// import 'bloc/my_cart_state.dart';
// import 'bloc/my_courses_event.dart';
//
// import 'package:provider/provider.dart';
// class CartPage extends StatefulWidget {
//   const CartPage({Key? key}) : super(key: key);
//
//
//   @override
//   State<CartPage> createState() => _CartPageState();
// }
// double totalPriceWithDiscount=0;
// double totalPrice=0;
// class _CartPageState extends State<CartPage> {
//   TextEditingController couponController=TextEditingController();
//   List<CouponsList> couponsList=[];
//   bool allowShowMsg=false;
//   CartEntity cartEntity=CartEntity(carts: []);
//   List<Widget> productsList=[];
//    List<Cart> cartList =[];
//   List<ApplyCouponEntity> applyCouponEntity=[];
//   double discountAmount=0;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size =MediaQuery.of(context).size;
//     var locale = AppLocalizations.of(context)!;
//     final cartChangeNotifier = Provider.of<CartChangeNotifier>(context);
//
//     return BlocProvider(
//         create: (BuildContext context) => sl<MyCartBloc>(),
//         child:
//         BlocBuilder<MyCartBloc, MyCartState>(builder: (context, state) {
//           if (kDebugMode) {
//             print("State:$state");
//           }
//
//
//           if (state is Empty) {
//             BlocProvider.of<MyCartBloc>(context)
//                 .add(GetAllProductsFromCart()); /// => SuccessGetCartEntity
//           }
//
//           if (state is SuccessDeleteProductFromCartEntity) {
//             BlocProvider.of<MyCartBloc>(context)
//                 .add(GetAllProductsFromCart()); /// => SuccessGetCartEntity
//           }
//           if(state is SuccessApplyCouponEntity){
//             ///After sending the coupon, the coupon will be applied to the respective courses.
//
//             if(state.applyCouponEntity.isNotEmpty){
//               if(state.applyCouponEntity.first.status=="Not Found"){
//                 Future.delayed(Duration.zero, () {
//                   showMessage(message: "هذا الكوبون غير موجود", context: context);
//                 });
//               }else   if(state.applyCouponEntity.first.status=="Not Available"){
//                 Future.delayed(Duration.zero, () {
//                   showMessage(message: "هذا الكوبون غير متاح", context: context);
//                 });
//               }
//             }
//
//
//             if(state.applyCouponEntity.isEmpty){
//               Future.delayed(Duration.zero, () {
//                 showMessage(message: "هذا الكوبون لايتضمن اي من الكورسات في السلة", context: context);
//               });
//             }
//
//             applyCouponEntity= state.applyCouponEntity;
//
//             BlocProvider.of<MyCartBloc>(context)
//                 .add(GetAllProductsFromCart());
//
//           }
//
//           if (state is SuccessGetCartEntity){
//             totalPriceWithDiscount=0;
//             totalPrice=0;
//             discountAmount=0;
//             couponsList=[];
//             productsList=[];
//             cartList=[];
//             cartEntity=state.cartEntity;
//             cartChangeNotifier.setCounter(state.cartEntity.carts.length);
//             for(var item in state.cartEntity.carts){
//
//               ///calculate price before any discount.
//               if (item.newPrice != 0) {
//               totalPrice += item.newPrice;
//               } else {
//               totalPrice += item.oldPrice;
//               }
//
//               ///This list is for applying the entered coupon to the products.
//               couponsList.add(CouponsList(type: item.productType, productId: item.apiId));
//
//
//               if(applyCouponEntity.isNotEmpty){
//
//                 bool courseEdit=false;
//                 for(var v in applyCouponEntity){
//                   if(v.courseId==item.apiId){
//                     courseEdit=true;
//                     double newPrice= calculateTheNewPrice(amount:v.amount,newPrice:item.newPrice,oldPrice:item.oldPrice);
//
//
//                     totalPriceWithDiscount +=newPrice;
//                     cartList.add(
//                         Cart(
//                             type: ProductType.course,
//                             couponApplied: false,
//                             couponCode: couponController.text,
//                             productId: item.apiId,
//                             productImage: item.image,
//                             productName: item.name,
//                             productPrice: newPrice,
//                             productOPrice: item.oldPrice
//                         )
//                     );
//                     productsList.add(Stack(
//                       alignment: Alignment.bottomRight,
//                       children: [
//                         ItemList(image: item.image, title: item.name, trainer: item.trainer,
//                           newPrice:newPrice, productType: item.productType,cartChangeNotifier:cartChangeNotifier,
//                           price: item.oldPrice, idFromLocaleDB: item.id, apiId: item.apiId,),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8,bottom: 16),
//                           child: Container(height: 25,
//                             width: 94,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color:percentIndicatorColor,
//                               borderRadius: BorderRadius.circular(4)
//                             ),
//                             child: Text("تم تطبيق الخصم",style: blackBoldTextStyle(fontSize: 10, context: context),),
//                           ),
//                         )
//                       ],
//                     ));
//
//
//                     ///Calculate the discount amount
//                     if (item.newPrice != 0) {
//                       discountAmount += item.newPrice-newPrice;
//                     } else {
//                       discountAmount += item.oldPrice-newPrice;
//                     }
//
//                   }
//                 }
//                 if(courseEdit==false){
//
//                   if (item.newPrice != 0) {
//                     totalPriceWithDiscount += item.newPrice;
//                   } else {
//                     totalPriceWithDiscount += item.oldPrice;
//                   }
//
//                   productsList.add(Stack(
//                     alignment: Alignment.topLeft,
//                     children: [
//                       ItemList(image: item.image, title: item.name, trainer: item.trainer, newPrice: item.newPrice, price: item.oldPrice,
//                         idFromLocaleDB: item.id, apiId: item.apiId, productType: item.productType, cartChangeNotifier: cartChangeNotifier,),
//                       // Container(width: 30,height: 30,color: Colors.red,)
//                     ],
//                   ));
//                 }
//
//
//
//               }
//               /// applyCouponEntity is empty => that mean  this coupon is not respective for any course
//               /// OR coupon was not sent yet.
//               else {
//
//
//                 cartList.add(
//                     Cart(
//                         type: item.productType,
//                         couponApplied: false,
//                         couponCode: couponController.text,
//                         productId: item.apiId,
//                         productImage: item.image,
//                         productName: item.name,
//                         productPrice: item.newPrice,
//                         productOPrice: item.oldPrice
//                     )
//                 );
//
//                 ///Products list widget.
//                 productsList.add(ItemList(image: item.image,
//                   title: item.name,
//                   trainer: item.trainer,
//                   newPrice: item.newPrice,
//                   price: item.oldPrice,
//                   apiId: item.apiId,
//                   idFromLocaleDB: item.id,
//                   productType: item.productType,
//                   cartChangeNotifier: cartChangeNotifier,
//                 ));
//
//
//                 /// Calculate the price before applying the coupon.
//                 if (item.newPrice != 0) {
//                   totalPriceWithDiscount += item.newPrice;
//                 } else {
//                   totalPriceWithDiscount += item.oldPrice;
//                 }
//               }
//             }
//
//           }
//
//           return Scaffold(
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             appBar:appBarWidget("${locale.cart!}  (${productsList.length})",context,true,null,null),
//             body:(productsList.isNotEmpty)? Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//
//                 SizedBox(
//                   height: double.infinity,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Column(children: productsList,),
//                         SizedBox(
//                           width: double.infinity,
//                           // color:      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 17,right: 17),
//                             child: Column(
//                               children: [
//
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 14),
//                                   child: Stack(
//                                     alignment: Alignment.bottomLeft,
//                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     // crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       SizedBox(
//                                           width: size.width,
//                                           child: CustomTextField(title:"كوبون الخصم",
//                                             hint: 'أدخل كوبون الخصم', onTap: () {  },
//                                             // onChange: (v){
//                                             //
//                                             // },
//                                             keyboardType: TextInputType.text,
//                                             controller: couponController,
//                                           )),
//                                       CustomButton(width: size.width*0.25,
//                                         onTap: () {
//                                           allowShowMsg=true;
//                                           BlocProvider.of<MyCartBloc>(context)
//                                               .add(ApplyCouponEvent(
//                                               applyCouponParams:
//                                               ApplyCouponParams(couponsList:couponsList,
//                                                   coupon: couponController.text)));
//
//
//                                         }, borderRadius: 6,height:47,fontSize: 12,
//
//                                         color:(couponController.text=="")? Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor,
//                                         title: "تطبيق",),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top:31),
//                                   child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(locale.price!,style: blackRegularTextStyle(fontSize:13  ),),
//                                         Text("$totalPrice\$",style: blackBoldTextStyle(context: context,fontSize: 16),),
//                                       ]
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top:31,bottom: 12.5),
//                                   child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(locale.discountAmount!,style: blackRegularTextStyle(fontSize:13  ),),
//                                         Text("$discountAmount\$""-",style: blackBoldTextStyle(context: context,fontSize: 16,color: Theme.of(context).primaryColor),),
//                                       ]
//                                   ),
//                                 ),
//
//                                 Text("-------------------------------------------------------------------------------------------------------------------------------",
//                                   maxLines: 1,style: TextStyle(
//                                       color: Colors.grey.withOpacity(0.5)
//                                   ),),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top:12.5,bottom: 16),
//                                   child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(locale.totalRequest!,style: blackBoldTextStyle(context: context,fontSize: 13  ),),
//                                         Text("$totalPriceWithDiscount\$",style: blackBoldTextStyle(context: context,fontSize: 16),),
//                                       ]
//                                   ),
//                                 ),
//                                 SizedBox(height: size.height*0.15,),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   height: 83,
//                   width: double.infinity,
//                 ),
//                 SafeArea(
//                   child: Container(
//                     color:Theme.of(context).cardColor,
//                     height: 83,
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 17,right: 17,top: 15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // GestureDetector(
//                           //   onTap: (){
//                           //     for(var item in cartList){
//                           //       print(item.type);
//                           //     }
//                           //
//                           //   },
//                           //     child: Container(width: size.width-40,height: 50,color: Colors.green,)),
//                           PaymentButton(price: totalPriceWithDiscount,width: size.width-34, cartList: cartList,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ): EmptyStateWidget(
//               svg: 'assets/svgs/emptyـcart.svg',
//               text1: 'سلة مشتريات فارغة!',
//               text3: 'قم بالشراء الآن',
//               onTap: (){
//                 Navigator.pop(context);
//               },
//             ),
//
//           );
//
//         }));
//
//
//
//
//
//   }
//
//
//
//
//
//   double calculateTheNewPrice({required double amount, required double newPrice, required double oldPrice}) {
//
//     // if (kDebugMode) {
//     //   print("oldPrice:$oldPrice");
//     //   print("newPrice:$newPrice");
//     //   print("amount:$amount");
//     //   print(oldPrice-(amount/100*oldPrice));
//     // }
//
//     if(newPrice!=0){
//       double nm=newPrice-(amount/100*newPrice);
//       return  double.parse(nm.toStringAsFixed(2));
//     }else{
//
//       double nm=oldPrice-(amount/100*oldPrice);
//     return  double.parse(nm.toStringAsFixed(2));
//
//     }
//
//   }
// }
//
//
//
//
// class ItemList extends StatelessWidget {
//   const ItemList({Key? key,
//     required this.image,
//     required this.title,
//     required this.trainer,
//     required this.newPrice,
//     required this.price,
//     required this.idFromLocaleDB,
//     required this.apiId,
//     required this.productType,
//     required this.cartChangeNotifier,
//   }) : super(key: key);
//
//   final String image;
//   final String title;
//   final String trainer;
//   final double newPrice;
//   final double price;
//   final int idFromLocaleDB;
//   final int apiId;
//   final int productType;
//   final CartChangeNotifier   cartChangeNotifier;
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size= MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: (){
//         ///Package from courses
//         if(productType==ProductType.package){
//           goTo(
//               context,
//                   (context) => CoursesContentPage(
//                 cardId: apiId,
//                     courseCover: image,
//               ));
//         }
//         ///For consultant
//         else if(productType==ProductType.consultant){
//           goTo(context, (context) => ConsultationById(
//             consultancyName:title,
//             id: apiId,
//             consultantImage:  image,
//             consultantName: trainer,
//
//           ));
//         }
//         ///For course and diploma
//         else{
//           goTo(
//               context,
//                   (context) => CourseContentPage(
//                 cardId: apiId,
//                 productType: ProductType.course,
//                courseCover: image,
//               ));
//         }
//
//       },
//       child: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             // color: Colors.white,
//             child: Row(
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10,right: 10,bottom: 17,top: 17),
//                   child: Container(
//                     width: 90,
//                     height: 90,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: CachedNetWorkImage(borderRadius: BorderRadius.circular(10),
//                       url:image,
//                       boxFit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       // color: Colors.red,
//                         width: size.width*0.65,
//                         child: Text(title,style: blackBoldTextStyle(context: context,fontSize: 12),)),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Text(trainer,style: blackBoldTextStyle(context: context,fontSize: 12),),
//                     ),
//
//
//                     Padding(
//                       padding: const EdgeInsets.only(top:10),
//                       child: Container(
//                         alignment: Alignment.bottomCenter,
//                         width: size.width-85-30,
//                         // color: Colors.red,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             PriceWidget(newPrice:newPrice,
//                               price:price,),
//
//                             Row(
//                               children: [
//                                 // Container(
//                                 //   width:42,
//                                 //   height:42,
//                                 //   alignment: Alignment.center,
//                                 //   decoration: BoxDecoration(
//                                 //     borderRadius: BorderRadius.circular(200),
//                                 //     // color: Colors.red,
//                                 //     color: Theme.of(context).cardColor.withOpacity(0.65),
//                                 //   ),
//                                 //   child: SvgPicture.asset(
//                                 //     "assets/svgs/favorite icon.svg",
//                                 //     color: iconsColor,
//                                 //     width: 17,
//                                 //   ),
//                                 // ),
//                                 // const SizedBox(width: 20,),
//                                 GestureDetector(
//                                   onTap:(){
//
//                                     showCustomDialog(context,idFromLocaleDB);
//
//                                   } ,
//                                   child: Container(
//                                     width:42,
//                                     height:42,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(200),
//                                       // color: Colors.red,
//                                       color: Theme.of(context).cardColor.withOpacity(0.65),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8),
//                                       child: SvgPicture.asset(
//                                         "assets/svgs/deleteIcon.svg",
//                                         width: 19,
//                                         color: iconsColor,
//                                         // height: 15,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10,),
//                               ],
//                             ),
//
//
//
//                           ],),
//                       ),
//                     ),
//
//
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Container(
//
//             color: Colors.grey,
//             height: 0.5,
//             width: size.width,
//           )
//         ],
//       ),
//     );
//   }
//
//
//   void showCustomDialog(BuildContext context, int id) {
//     showGeneralDialog(
//       context: context,
//       barrierLabel: "Barrier",
//       barrierDismissible: true,
//       barrierColor: iconsColor.withOpacity(0.3),
//       transitionDuration: const Duration(milliseconds: 200),
//       pageBuilder: (contextt, __, ___) {
//         var locale = AppLocalizations.of(context)!;
//
//         return Scaffold(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
//           body: BlocProvider(
//               create: (BuildContext context) => sl<MyCartBloc>(),
//               child: BlocBuilder<MyCartBloc, MyCartState>(
//                   builder: (context, state) {
//                     if (kDebugMode) {
//                       print("State:$state");
//                     }
//                     return Center(
//                       child: Container(
//                         height: 130,
//                         width: double.infinity,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Scaffold(
//                             body: Padding(
//                               padding: const EdgeInsets.only(right: 27, left: 35),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.only(top: 17, bottom: 9.7),
//                                     child: Text(
//                                       locale.confirmDeletion!,
//                                       style: blackBoldTextStyle(
//                                           context: context, fontSize: 14),
//                                     ),
//                                   ),
//                                   Text(
//                                     locale.areSureOfTheDeletingProcess!,
//                                     style: blackBoldTextStyle(
//                                         context: context, fontSize: 12),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 21),
//                                     child: Row(
//                                       children: [
//                                         GestureDetector(
//                                             onTap: () {
//                                               Navigator.pop(contextt);
//                                             },
//                                             child:Container(
//                                               color: Theme.of(context).scaffoldBackgroundColor,
//
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(7),
//                                                 child: Text(
//                                                   locale.noCancelTheDeletion!,
//                                                   style: blackBoldTextStyle(
//                                                       context: context,
//                                                       fontSize: 12,
//                                                       color:
//                                                       Theme.of(context).primaryColor),
//                                                 ),
//                                               ),
//                                             )),
//                                         const SizedBox(
//                                           width: 52,
//                                         ),
//                                         GestureDetector(
//                                             onTap: () {
//                                               Navigator.pop(contextt, 200);
//                                             },
//                                             child: Container(
//                                               color: Theme.of(context).scaffoldBackgroundColor,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(7),
//                                                 child: Text(
//                                                   locale.yesIWantToDelete!,
//                                                   style: blackBoldTextStyle(
//                                                       context: context,
//                                                       fontSize: 12,
//                                                       color:
//                                                       Theme.of(context).primaryColor),
//                                                 ),
//                                               ),
//                                             )),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         margin: const EdgeInsets.symmetric(horizontal: 20),
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     );
//                   })),
//         );
//       },
//       transitionBuilder: (_, anim, __, child) {
//         Tween<Offset> tween;
//         if (anim.status == AnimationStatus.reverse) {
//           tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
//         } else {
//           tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
//         }
//
//         return SlideTransition(
//           position: tween.animate(anim),
//           child: FadeTransition(
//             opacity: anim,
//             child: child,
//           ),
//         );
//       },
//     ).then((value) {
//       if (value == 200) {
//         // final cartChangeNotifier = Provider.of<CartChangeNotifier>(context);
//         // cartChangeNotifier.decrease();
//         BlocProvider.of<MyCartBloc>(context)
//             .add(DeleteProductToCart(id:idFromLocaleDB));
//
//
//       }
//     });
//   }
// }
