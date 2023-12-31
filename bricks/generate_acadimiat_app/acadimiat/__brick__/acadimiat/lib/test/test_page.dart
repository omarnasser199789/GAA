// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
//
// class TestPage extends StatefulWidget {
//   @override
//   _TestPageState createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//
//   final InAppPurchase _iap = InAppPurchase.instance;
//   List<ProductDetails> _products = [];
//   bool _isAvailable = false;
//   bool _isLoading = false;
//
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//
//   @override
//   void initState() {
//     final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
//     super.initState();
//     initStoreInfo();
//     _subscription = purchaseUpdated.listen((data) {
//       handlePurchaseUpdates(data);
//     });
//   }
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   Future<void> initStoreInfo() async {
//     final bool available = await _iap.isAvailable();
//     if (!available) {
//       setState(() {
//         _isAvailable = false;
//       });
//       return;
//     }
//
//     final ProductDetailsResponse response =
//     await _iap.queryProductDetails({'netflix_10_coins'}.toSet());
//     if (response.notFoundIDs.isNotEmpty) {
//       setState(() {
//         _isAvailable = false;
//       });
//       return;
//     }
//
//     setState(() {
//       _isAvailable = true;
//       _products = response.productDetails;
//     });
//   }
//
//   Future<void> purchaseProduct(ProductDetails product) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
//     final bool purchaseDetails =
//     await _iap.buyNonConsumable(purchaseParam: purchaseParam);
//
//     print("fdkjbvjkdfbvbds");
//     print(purchaseDetails);
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     // if (purchaseDetails.status == PurchaseStatus.purchased) {
//     //   // Purchase successful, handle accordingly
//     // } else if (purchaseDetails.status == PurchaseStatus.error) {
//     //   // Purchase failed, handle accordingly
//     // }
//   }
//
//   void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
//     for (var purchaseDetails in purchaseDetailsList) {
//       print("fdkhbvjhdfbvjhbdfbvsd******");
//       print(purchaseDetails.status);
//       if (purchaseDetails.status == PurchaseStatus.purchased) {
//         // Purchase successful, handle accordingly
//       } else if (purchaseDetails.status == PurchaseStatus.error) {
//         // Purchase failed, handle accordingly
//       }
//       // Handle other purchase statuses if needed
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('In-App Purchase Example'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'Available: $_isAvailable',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Products:',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 SizedBox(height: 8),
//                 Column(
//                   children: _products.map((product) {
//                     return ElevatedButton(
//                       child: Text(
//                         product.title,
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       onPressed: _isLoading
//                           ? null
//                           : () => purchaseProduct(product),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             Container(
//               color: Colors.black54,
//               child: Center(
//                 child: SpinKitCircle(
//                   color: Colors.white,
//                   size: 50.0,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
