
// import 'dart:convert';

// import 'package:emastery/feature/profile_feature/domain/entities/my_notifications_entity.dart';

// List<MyNotificationsModel> myNotificationModelFromJson(String str) => List<MyNotificationsModel>.from(json.decode(str).map((x) => MyNotificationsModel.fromJson(x)));

// String myNotificationModelToJson(List<MyNotificationsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class MyNotificationsModel  extends MyNotificationEntity{
//     MyNotificationsModel({
//       required  this.id,
//       required  this.userId,
//       required  this.notifications,
//     }):super(id: id,userId: userId,notifications: notifications);

//     int id;
//     int userId;
//     List<dynamic> notifications;

//     factory MyNotificationsModel.fromJson(Map<String, dynamic> json) => MyNotificationsModel(
//         id: json["id"],
//         userId: json["userId"],
//         notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "notifications": List<dynamic>.from(notifications.map((x) => x)),
//     };
// }
