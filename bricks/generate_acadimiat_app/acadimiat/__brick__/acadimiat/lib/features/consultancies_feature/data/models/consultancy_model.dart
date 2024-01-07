import 'dart:convert';
import '../../domain/entities/consultancy_entity.dart';

ConsultancyModel consultancyModelFromJson(String str) => ConsultancyModel.fromJson(json.decode(str));

String consultancyModelToJson(ConsultancyModel data) => json.encode(data.toJson());

class ConsultancyModel  extends ConsultancyEntity{
  ConsultancyModel({
  required  this.consultancyId,
  required  this.name,
  required  this.body,
  required  this.image,
  required  this.consultantName,
  required  this.numberOfSessions,
  required  this.subscriptionLimit,
  required  this.typeOfSession,
  required  this.squareImage,
  required  this.consultantImage,
  required  this.consultantInfo,
  required  this.consultantId,
  required  this.consultancyPrice,
  required  this.timeLimit,
  required  this.info,
  }):super(
    consultancyId:consultancyId,
    name:name,
    body:body,
    image:image,
    consultantName:consultantName,
    numberOfSessions:numberOfSessions,
    subscriptionLimit:subscriptionLimit,
    typeOfSession:typeOfSession,
    squareImage:squareImage,
    consultantImage:consultantImage,
    consultantInfo:consultantInfo,
    consultantId:consultantId,
    consultancyPrice:consultancyPrice,
    timeLimit:timeLimit,
    info:info,
  );

 final int consultancyId;
 final String name;
 final dynamic body;
 final String image;
 final String consultantName;
 final int numberOfSessions;
 final String subscriptionLimit;
 final String typeOfSession;
 final dynamic squareImage;
 final String consultantImage;
 final String consultantInfo;
 final int consultantId;
 final double consultancyPrice;
 final double timeLimit;
 final List<Info> info;

  factory ConsultancyModel.fromJson(Map<String, dynamic> json) => ConsultancyModel(
    consultancyId: json["consultancyId"],
    name: json["name"],
    body: json["body"],
    image: json["image"],
    consultantName: json["consultantName"],
    numberOfSessions: json["numberOfSessions"],
    subscriptionLimit: json["subscriptionLimit"],
    typeOfSession: json["typeOfSession"],
    squareImage: json["squareImage"],
    consultantImage: json["consultantImage"],
    consultantInfo: json["consultantInfo"],
    consultantId: json["consultantId"],
    consultancyPrice: json["consultancyPrice"],
    timeLimit: json["timeLimit"],
    info: List<Info>.from(json["info"].map((x) => Info.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "consultancyId": consultancyId,
    "name": name,
    "body": body,
    "image": image,
    "consultantName": consultantName,
    "numberOfSessions": numberOfSessions,
    "subscriptionLimit": subscriptionLimit,
    "typeOfSession": typeOfSession,
    "squareImage": squareImage,
    "consultantImage": consultantImage,
    "consultantInfo": consultantInfo,
    "consultantId": consultantId,
    "consultancyPrice": consultancyPrice,
    "timeLimit": timeLimit,
    "info": List<dynamic>.from(info.map((x) => x.toJson())),
  };
}

class Info {
  Info({
  required  this.id,
  required  this.consultancyId,
  required  this.consultancy,
  required  this.order,
  required  this.header,
  required  this.body,
  required  this.videoId,
  required  this.video,
  });

  int id;
  int consultancyId;
  Consultancy consultancy;
  int order;
  String header;
  String body;
  dynamic videoId;
  dynamic video;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    consultancyId: json["consultancyId"],
    consultancy: Consultancy.fromJson(json["consultancy"]),
    order: json["order"],
    header: json["header"],
    body: json["body"],
    videoId: json["videoId"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultancyId": consultancyId,
    "consultancy": consultancy.toJson(),
    "order": order,
    "header": header,
    "body": body,
    "videoId": videoId,
    "video": video,
  };
}

class Consultancy {
  Consultancy({
 required  this.id,
 required  this.consultantId,
 required  this.consultant,
 required  this.squareImage,
 required  this.active,
 required  this.name,
 required  this.body,
 required  this.time,
 required  this.numberOfSessions,
 required  this.subscriptionLimit,
 required  this.typeOfSession,
 required  this.price,
 required  this.notes,
 required  this.image,
  });

  int id;
  int consultantId;
  Consultant consultant;
  dynamic squareImage;
  bool active;
  String name;
  dynamic body;
  double time;
  int numberOfSessions;
  String subscriptionLimit;
  String typeOfSession;
  double price;
  String notes;
  String image;

  factory Consultancy.fromJson(Map<String, dynamic> json) => Consultancy(
    id: json["id"],
    consultantId: json["consultantId"],
    consultant: Consultant.fromJson(json["consultant"]),
    squareImage: json["squareImage"],
    active: json["active"],
    name: json["name"],
    body: json["body"],
    time: json["time"],
    numberOfSessions:( json["numberOfSessions"]!=null)? json["numberOfSessions"]:0,
    subscriptionLimit: (json["subscriptionLimit"]!=null)?json["subscriptionLimit"]:"",
    typeOfSession: (json["typeOfSession"]!=null)?json["typeOfSession"]:"",
    price: (json["price"]!=null)?json["price"]:0.0,
    notes: (json["notes"]!=null)?json["notes"]:"",
    image: (json["image"]!=null)?json["image"]:"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultantId": consultantId,
    "consultant": consultant.toJson(),
    "squareImage": squareImage,
    "active": active,
    "name": name,
    "body": body,
    "time": time,
    "numberOfSessions": numberOfSessions,
    "subscriptionLimit": subscriptionLimit,
    "typeOfSession": typeOfSession,
    "price": price,
    "notes": notes,
    "image": image,
  };
}

class Consultant {
  Consultant({
 required  this.id,
 required  this.userId,
 required  this.groupId,
 required  this.name,
 required  this.email,
 required  this.info,
 required  this.moreInfo,
 required  this.phone,
 required  this.profileImage,
 required  this.notes,
 required  this.addedBy,
 required  this.addedDate,
 required  this.updateAt,
 required  this.user,
 required  this.group,
  });

  int id;
  dynamic userId;
  int groupId;
  String name;
  String email;
  String info;
  String moreInfo;
  String phone;
  String profileImage;
  String notes;
  int addedBy;
  DateTime addedDate;
  dynamic updateAt;
  dynamic user;
  dynamic group;

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
    id: json["id"],
    userId: json["userId"],
    groupId: json["groupId"],
    name:( json["name"]!=null)? json["name"]:"",
    email: (json["email"]!=null)?json["email"]:"",
    info: (json["info"]!=null)?json["info"]:"",
    moreInfo:( json["moreInfo"]!=null)? json["moreInfo"]:"",
    phone: (json["phone"]!=null)?json["phone"]:"",
    profileImage: (json["profileImage"]!=null)?json["profileImage"]:"",
    notes: (json["notes"]!=null)?json["notes"]:"",
    addedBy: json["addedBy"],
    addedDate: DateTime.parse(json["addedDate"]),
    updateAt: json["updateAt"],
    user: json["user"],
    group: json["group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "groupId": groupId,
    "name": name,
    "email": email,
    "info": info,
    "moreInfo": moreInfo,
    "phone": phone,
    "profileImage": profileImage,
    "notes": notes,
    "addedBy": addedBy,
    "addedDate": addedDate.toIso8601String(),
    "updateAt": updateAt,
    "user": user,
    "group": group,
  };
}
