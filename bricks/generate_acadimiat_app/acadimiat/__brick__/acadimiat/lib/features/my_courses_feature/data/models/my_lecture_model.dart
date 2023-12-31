// To parse this JSON data, do
//
//     final myLectureModel = myLectureModelFromJson(jsonString);

import 'dart:convert';

import '../../../../core/classes/matched.dart';
import '../../../../core/classes/order.dart';
import '../../../../core/classes/question.dart';
import '../../../../core/classes/word_type1.dart';
import '../../../../core/classes/word_type4.dart';
import '../../domain/entities/my_lecture_entity.dart';

MyLectureModel myLectureModelFromJson(String str) => MyLectureModel.fromJson(json.decode(str));

String myLectureModelToJson(MyLectureModel data) => json.encode(data.toJson());

class MyLectureModel  extends MyLectureEntity {
  MyLectureModel({
  required this.materialId,
  required this.materialName,
  required this.unitId,
  required this.order,
  required this.materialLink,
  required this.materialLength,
  required this.isDone,
  required this.totalScore,
  required this.completitionDate,
  required this.currentVideo,
   required this.discussion,
  required this.contents,
  }):super(
    materialId:materialId,
    materialName:materialName,
    unitId:unitId,
    order:order,
    materialLink:materialLink,
    materialLength:materialLength,
    isDone:isDone,
    totalScore:totalScore,
    completitionDate:completitionDate,
    currentVideo:currentVideo,
    discussion:discussion,
    contents:contents,
  );

  int materialId;
  String materialName;
  int unitId;
  int order;
  String materialLink;
  String materialLength;
  bool isDone;
  double totalScore;
  dynamic completitionDate;
  CurrentVideo  currentVideo;
  Discussion   discussion;
  List<NestedContent> contents;

  factory MyLectureModel.fromJson(Map<String, dynamic> json) => MyLectureModel(
    materialId: (json["materialId"]!=null)?json["materialId"]:-1,
    materialName: (json["materialName"]!=null)?json["materialName"]:"",
    unitId: (json["unitId"]!=null)?json["unitId"]:-1,
    order: (json["order"]!=null)?json["order"]:-1,
    materialLink: (json["materialLink"]!=null)?json["materialLink"]:"",
    materialLength: (json["materialLength"]!=null)?json["materialLength"]:"",
    isDone: (json["isDone"]!=null)?json["isDone"]:false,
    totalScore:( json["totalScore"]!=null)? json["totalScore"]:0.0,
    completitionDate: (json["completitionDate"]!=null)?json["completitionDate"]:null,
    currentVideo:(json["currentVideo"]!=null)? CurrentVideo.fromJson(json["currentVideo"]):
    CurrentVideo(bookmarks: [], url: '', currentTime: null, questions: [])
    ,
    discussion:(json["discussion"]!=null)? Discussion.fromJson(json["discussion"]):
    Discussion(lectureId: null, timeline: null, discussionId: -1),
    contents:(json["contents"]!=null)? List<NestedContent>.from(json["contents"].map((x) => NestedContent.fromJson(x))):[],

  );

  Map<String, dynamic> toJson() => {
    "materialId": materialId,
    "materialName": materialName,
    "unitId": unitId,
    "order": order,
    "materialLink": materialLink,
    "materialLength": materialLength,
    "isDone": isDone,
    "totalScore": totalScore,
    "completitionDate": completitionDate,
    "currentVideo": currentVideo.toJson(),
    "discussion": discussion.toJson(),
    "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
  };
}





class NestedContent {
  NestedContent({
  required  this.id,
  required  this.materialId,
  required  this.order,
  required  this.type,

  required  this.fileId,
  required  this.file,
  required  this.activityId,
  required  this.activity,
  required  this.meetingLink,
  required  this.isFree,
  required  this.fileUrl,
  required  this.body,
  required  this.url,
  required  this.currentTime,
  required  this.questions,
  required  this.bookmarks,
  });

  int id;
  int materialId;
  dynamic order;
  int type;
  int fileId;
  FileClass file;
  dynamic activityId;
  Activity activity;
  String meetingLink;
  bool isFree;
  String fileUrl;
  String body;
  String url;
  dynamic currentTime;
  List<dynamic> questions;
  List<Bookmark> bookmarks;

  factory NestedContent.fromJson(Map<String, dynamic> json) => NestedContent(
    id: (json["id"]!=null)?json["id"]:-1,
    materialId: (json["materialId"]!=null)?json["materialId"]:-1,
    order: json["order"],
    type:( json["type"]!=null)? json["type"]:-1,
    fileId: (json["fileId"]!=null)?json["fileId"]:-1,
    file:(json["file"]!=null)? FileClass.fromJson(json["file"]):
    FileClass(isVimeo: null,
        clipId: null, type: -1, name: '', fileSize: '',
        uploadedBy: null,
        fileName: '',
        allMaterials: null,
        length: -1,
        uploadDate: DateTime.now(),
        id: -1),
    activityId: json["activityId"],
    activity:(json["activity"]!=null)? Activity.fromJson(json["activity"]):Activity(caseStudy:
    CaseStudy(id: -1, addedBy: null,
        addedAt: DateTime.now(),
        title: null,
        body: null,
        openCase: false, caseHeader: '', caseBody: '', solution: Solution(id: -1, answers: []), attendanceTable: [])),
    meetingLink: (json["meetingLink"]!=null)?json["meetingLink"]:"",
    isFree: json["isFree"],
    fileUrl: (json["fileUrl"]!=null)?json["fileUrl"]:"",
    body: (json["body"]!=null)?json["body"]:"",
    url: (json["url"]!=null)?json["url"]:"",
    currentTime: json["currentTime"],
    questions: List<dynamic>.from(json["questions"].map((x) => x)),
    bookmarks: (json["bookmarks"]!=null)?List<Bookmark>.from(json["bookmarks"].map((x) => Bookmark.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialId": materialId,
    "order": order,
    "type": type,
    "fileId": fileId,
    "file": file.toJson(),
    "activityId": activityId,
    // "activity": activity.toJson(),
    "meetingLink": meetingLink,
    "isFree": isFree,
    "fileUrl": fileUrl,
    "body": body,
    "url": url,
    "currentTime": currentTime,
    "questions": List<dynamic>.from(questions.map((x) => x)),
    "bookmarks": List<dynamic>.from(bookmarks.map((x) => x.toJson())),
  };
}

class Activity {
  Activity({
    this.id,
    this.type,
    this.title,
    this.decision,
   required this.caseStudy,
    this.matching,
    this.filling,
    this.quizz,
    this.logicalOrder,
  });

  dynamic  id;
  int ? type;
  dynamic  title;
  Decision ? decision;
  CaseStudy   caseStudy;
  Matching ?  matching;
  Filling ?filling;
  Quizz ? quizz;
  LogicalOrder ? logicalOrder;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: (json["id"]!=null)? json["id"]:-1,
    type: (json["type"]!=null)?json["type"]:-1,
    title: json["title"],
    decision: json["decision"] == null ? null : Decision.fromJson(json["decision"]),
    caseStudy:(json["caseStudy"]!=null)? CaseStudy.fromJson(json["caseStudy"]):
    CaseStudy(id: -1, addedBy: null,
        addedAt: DateTime.now(), title: null, body: null, caseHeader: '', openCase: false, caseBody: '',
        solution: Solution(id: -1, answers: []), attendanceTable: []),


    matching: json["matching"] == null ? Matching(id: -1, title: '', sentences: [],
        relations: [], attendanceTable: []) : Matching.fromJson(json["matching"]),
    filling: json["filling"] == null ? Filling(id: -1, title: '', stripped: '', words: [], attendanceTable: []) : Filling.fromJson(json["filling"]),
    quizz: json["quizz"] == null ? null : Quizz.fromJson(json["quizz"]),
    logicalOrder: json["logicalOrder"] == null ? null : LogicalOrder.fromJson(json["logicalOrder"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "decision": decision,
    "caseStudy": caseStudy.toJson(),
    "filling": filling == null ? null : filling,
    "filling": filling,
    "quizz": quizz,
    "logicalOrder": logicalOrder == null ? LogicalOrder(id: -1, title: '', sentences: [], attendanceTable: [], relations: []) : logicalOrder!.toJson(),
  };
}
class CaseStudy {
  CaseStudy({
  required  this.id,
  required  this.addedBy,
  required  this.addedAt,
  required  this.title,
  required  this.body,
  required  this.openCase,
  required  this.caseHeader,
  required  this.caseBody,
  required  this.solution,
  required  this.attendanceTable,
  });

  int id;
  dynamic addedBy;
  DateTime addedAt;
  dynamic title;
  dynamic body;
  bool openCase;
  String caseHeader;
  String caseBody;
  Solution solution;
  List<AttendanceTable2> attendanceTable;

  factory CaseStudy.fromJson(Map<String, dynamic> json) => CaseStudy(
    id:( json["id"]!=null)? json["id"]:-1,
    addedBy: json["addedBy"],
    addedAt:(json["addedAt"]!=null)? DateTime.parse(json["addedAt"]):DateTime.now(),
    title: (json["title"]!=null)?json["title"]:"",
    body: json["body"],
    openCase: (json["openCase"]!=null)?json["openCase"]:false,
    caseHeader: (json["caseHeader"]!=null)?json["caseHeader"]:"",
    caseBody: (json["caseBody"]!=null)?json["caseBody"]:"",
    solution: (json["solution"]!=null)?Solution.fromJson(json["solution"]):Solution(id: -1, answers: []),
    attendanceTable:(json["attendanceTable"]!=null)? List<AttendanceTable2>.from(json["attendanceTable"].map((x) => AttendanceTable2.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addedBy": addedBy,
    "addedAt": addedAt.toIso8601String(),
    "title": title,
    "body": body,
    "openCase": openCase,
    "caseHeader": caseHeader,
    "caseBody": caseBody,
    "solution": solution.toJson(),
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}
class AttendanceTable2 {
  AttendanceTable2({
  required this.id,
  required this.userId,
  required this.answerId,
  required this.caseId,
  required this.correctAnswerId,
  required this.correctAnswer,
  required this.email,
  required this.solution,
  required this.explanation,
  required this.explanation2,
  required this.isCorrect,
  required this.reply,
  required this.answer,
  required this.date,
  });

  int id;
  int userId;
  int answerId;
  int caseId;
  int correctAnswerId;
  String correctAnswer;
  dynamic email;
  dynamic solution;
  String explanation;
  String explanation2;
  bool isCorrect;
  dynamic reply;
  dynamic answer;
  DateTime date;

  factory AttendanceTable2.fromJson(Map<String, dynamic> json) => AttendanceTable2(
    id: (json["id"]!=null)?json["id"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    answerId:( json["answerId"]!=null)? json["answerId"]:-1,
    caseId:( json["caseId"]!=null)? json["caseId"]:-1,
    correctAnswerId: (json["correctAnswerId"]!=null)?json["correctAnswerId"]:-1,
    correctAnswer: (json["correctAnswer"]!=null)?json["correctAnswer"]:"",
    email: json["email"],
    solution: json["solution"],
    explanation: (json["explanation"]!=null)?json["explanation"]:"",
    explanation2: (json["explanation2"]!=null)?json["explanation2"]:"",
    isCorrect: (json["isCorrect"]!=null)?json["isCorrect"]:false,
    reply: json["reply"],
    answer: json["answer"],
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "answerId": answerId,
    "caseId": caseId,
    "correctAnswerId": correctAnswerId,
    "correctAnswer": correctAnswer,
    "email": email,
    "solution": solution,
    "explanation": explanation,
    "explanation2": explanation2,
    "isCorrect": isCorrect,
    "reply": reply,
    "answer": answer,
    "date": date.toIso8601String(),
  };
}

class Solution {
  Solution({
  required this.id,
  required this.answers,
  });

  int id;
  List<Answer> answers;

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
    id: (json["id"]!=null)?json["id"]:-1,
    answers:(json["answers"]!=null)? List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}
class LogicalOrder {
  LogicalOrder({
   required this.id,
   required this.title,
   required this.sentences,
   required this.attendanceTable,
   required this.relations,
  });

  int id;
  String title;
  List<Sentence> sentences;
  List<LogicalOrderAttendanceTable> attendanceTable;
  List<Sentence> relations;

  factory LogicalOrder.fromJson(Map<String, dynamic> json) => LogicalOrder(
    id: (json["id"]!=null)?json["id"]:-1,
    title:( json["title"]!=null)? json["title"]:"",
    sentences:(json["sentences"]!=null)? List<Sentence>.from(json["sentences"].map((x) => Sentence.fromJson(x))):[],
    attendanceTable: (json["attendanceTable"]!=null)?List<LogicalOrderAttendanceTable>.from(json["attendanceTable"].map((x) => LogicalOrderAttendanceTable.fromJson(x))):[],
    relations: json["relations"] == null ? [] : List<Sentence>.from(json["relations"].map((x) => Sentence.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sentences": List<dynamic>.from(sentences.map((x) => x.toJson())),
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
    "relations": relations == null ? null : List<dynamic>.from(relations.map((x) => x.toJson())),
  };
}


class LogicalOrderAttendanceTable {
  LogicalOrderAttendanceTable({
  required  this.id,
  required  this.userId,
  required  this.questionId,
  required  this.email,
  required  this.isCorrect,
  required  this.date,
  required  this.orders,
  });

  int id;
  int userId;
  dynamic questionId;
  dynamic email;
  dynamic isCorrect;
  DateTime date;
  List<Order> orders;

  factory LogicalOrderAttendanceTable.fromJson(Map<String, dynamic> json) => LogicalOrderAttendanceTable(
    id: (json["id"]!=null)?json["id"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    questionId: json["questionId"],
    email: json["email"],
    isCorrect: json["isCorrect"],
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
    orders:(json["orders"]!=null)? List<Order>.from(json["orders"].map((x) => Order.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "questionId": questionId,
    "email": email,
    "isCorrect": isCorrect,
    "date": date.toIso8601String(),
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}
// class Order {
//   Order({
//   required  this.id,
//   required  this.sentenceId,
//   required  this.order,
//   required  this.correct,
//   });
//
//   int id;
//   int sentenceId;
//   int order;
//   int correct;
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//     id: json["id"],
//     sentenceId: json["sentenceId"],
//     order: json["order"],
//     correct: json["correct"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "sentenceId": sentenceId,
//     "order": order,
//     "correct": correct,
//   };
// }
class MatchingAttendanceTable {
  MatchingAttendanceTable({
    required  this.id,
    required  this.userId,
    required  this.questionId,
    required  this.email,
    required  this.isCorrect,
    required  this.date,
    required  this.matched,
  });

  int id;
  int userId;
  dynamic questionId;
  dynamic email;
  dynamic isCorrect;
  DateTime date;
  List<Matched> matched;

  factory MatchingAttendanceTable.fromJson(Map<String, dynamic> json) => MatchingAttendanceTable(
    id: (json["id"]!=null)?json["id"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    questionId: json["questionId"],
    email: json["email"],
    isCorrect: json["isCorrect"],
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
    matched: (json["matched"]!=null)?List<Matched>.from(json["matched"].map((x) => Matched.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "questionId": questionId,
    "email": email,
    "isCorrect": isCorrect,
    "date": date.toIso8601String(),
    "matched": List<dynamic>.from(matched.map((x) => x.toJson())),
  };
}
class AttendanceTable {
  AttendanceTable({
    this.id,
    this.userId,
    this.email,
    this.questionId,
    this.sentence,
    this.correct,
    this.opinion,
    this.isCorrect,
    this.reply,
    this.answer,
    this.date,
    required  this.words,
  });

  int ? id;
  int ?userId;
  dynamic  email;
  String ? opinion;
  int ?questionId;
  dynamic sentence;
  dynamic correct;
  dynamic isCorrect;
  dynamic reply;
  dynamic answer;
  DateTime? date;
  List<WordType4> words;

  factory AttendanceTable.fromJson(Map<String, dynamic> json) => AttendanceTable(
    id: (json["id"]!=null)?json["id"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    email: json["email"],
    opinion: (json["opinion"]!=null)?json["opinion"]:"",
    questionId: (json["questionId"]!=null)?json["questionId"]:-1,
    sentence: json["sentence"],
    correct: json["correct"],
    isCorrect: json["isCorrect"],
    reply: json["reply"],
    answer: json["answer"],
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
    words: (json["words"]!=null)?List<WordType4>.from(json["words"].map((x) => WordType4.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "email": email,
    "questionId": questionId,
    "sentence": sentence,
    "correct": correct,
    "isCorrect": isCorrect,
    "reply": reply,
    "answer": answer,
    "date": date!.toIso8601String(),
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
  };
}






class Filling {
  Filling({
  required  this.id,
  required  this.title,
  required  this.stripped,
  required  this.words,
  required  this.attendanceTable,
  });

  int id;
  String title;
  String stripped;
  List<WordType1> words;
  List<AttendanceTable> attendanceTable;

  factory Filling.fromJson(Map<String, dynamic> json) => Filling(
    id: (json["id"]!=null)?json["id"]:-1,
    title: (json["title"]!=null)?json["title"]:"",
    stripped: (json["stripped"]!=null)?json["stripped"]:"",
    words:(json["words"]!=null)? List<WordType1>.from(json["words"].map((x) => WordType1.fromJson(x))):[],
    attendanceTable:(json["attendanceTable"]!=null)? List<AttendanceTable>.from(json["attendanceTable"].map((x) => AttendanceTable.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "stripped": stripped,
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}
class Sentence {
  Sentence({
    required  this.id,
    required  this.sentence,
  });

  int id;
  String sentence;

  factory Sentence.fromJson(Map<String, dynamic> json) => Sentence(
    id: (json["id"]!=null)?json["id"]:-1,
    sentence: (json["sentence"]!=null)?json["sentence"]:"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sentence": sentence,
  };
}


class Matching {
  Matching({
  required this.id,
  required this.title,
  required this.sentences,
  required this.relations,
  required this.attendanceTable,
  });

  int id;
  String title;
  List<Relation> sentences;
  List<Relation> relations;
  List<MatchingAttendanceTable> attendanceTable;

  factory Matching.fromJson(Map<String, dynamic> json) => Matching(
    id: (json["id"]!=null)?json["id"]:-1,
    title: (json["title"]!=null)?json["title"]:"",
    sentences:(json["sentences"]!=null)? List<Relation>.from(json["sentences"].map((x) => Relation.fromJson(x))):[],
    relations: (json["relations"]!=null)?List<Relation>.from(json["relations"].map((x) => Relation.fromJson(x))):[],
    attendanceTable:(json["attendanceTable"]!=null)? List<MatchingAttendanceTable>.from(json["attendanceTable"].map((x) => MatchingAttendanceTable.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sentences": List<dynamic>.from(sentences.map((x) => x.toJson())),
    "relations": List<dynamic>.from(relations.map((x) => x.toJson())),
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}
class Relation {
  Relation({
  required this.id,
  required this.sentence,
  });

  int id;
  String sentence;

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
    id: (json["id"]!=null)?json["id"]:-1,
    sentence: (json["sentence"]!=null)?json["sentence"]:"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sentence": sentence,
  };
}
class Bookmark {
  Bookmark({
  required  this.id,
  required  this.userId,
  required  this.videoId,
  required  this.atTime,
  required  this.note,
    this.video,
  required  this.user,
  });

  int id;
  int userId;
  int videoId;
  int atTime;
  String note;
  FileClass ? video;
  dynamic user;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
    id: (json["id"]!=null)?json["id"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    videoId: (json["videoId"]!=null)?json["videoId"]:-1,
    atTime: (json["atTime"]!=null)?json["atTime"]:-1,
    note: (json["note"]!=null)?json["note"]:"",
    video:(json["video"]!=null)? FileClass.fromJson(json["video"]):
    FileClass(id: -1, fileName: '',
        name: '', clipId: -1, fileSize: '', type: -1,
        uploadDate: DateTime.now(), length: -1, uploadedBy: -1,
        isVimeo: false, allMaterials: null
    ),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "videoId": videoId,
    "atTime": atTime,
    "note": note,
    "video": video!.toJson(),
    "user": user,
  };
}
class FileClass {
  FileClass({
  required this.id,
  required this.fileName,
  required this.name,
  required this.clipId,
  required this.type,
  required this.fileSize,
  required this.uploadDate,
  required this.length,
  required this.uploadedBy,
  required this.isVimeo,
  required this.allMaterials,
  });

  int id;
  String fileName;
  String name;
  dynamic clipId;
  int type;
  String fileSize;
  DateTime uploadDate;
  double length;
  dynamic uploadedBy;
  dynamic isVimeo;
  dynamic allMaterials;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    id: (json["id"]!=null)?json["id"]:-1,
    fileName: (json["fileName"]!=null)?json["fileName"]:"",
    name: (json["name"]!=null)?json["name"]:"",
    clipId: json["clipId"],
    type: (json["type"]!=null)?json["type"]:-1,
    fileSize: (json["fileSize"]!=null)?json["fileSize"]:"",
    uploadDate: (json["uploadDate"]!=null)?DateTime.parse(json["uploadDate"]):DateTime.now(),
    length: (json["length"]!=null)?json["length"]:0.0,
    uploadedBy: json["uploadedBy"],
    isVimeo: json["isVimeo"],
    allMaterials: json["allMaterials"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileName": fileName,
    "name": name,
    "clipId": clipId,
    "type": type,
    "fileSize": fileSize,
    "uploadDate": uploadDate.toIso8601String(),
    "length": length,
    "uploadedBy": uploadedBy,
    "isVimeo": isVimeo,
    "allMaterials": allMaterials,
  };
}

class CurrentVideo {
  CurrentVideo({
  required this.url,
  required this.currentTime,
  required this.questions,
  required this.bookmarks,
  });

  String url;
  dynamic currentTime;
  List<dynamic> questions;
  List<Bookmark> bookmarks;

  factory CurrentVideo.fromJson(Map<String, dynamic> json) => CurrentVideo(
    url: (json["url"]!=null)?json["url"]:"",
    currentTime: json["currentTime"],
    questions: List<dynamic>.from(json["questions"].map((x) => x)),
    bookmarks:(json["bookmarks"]!=null)? List<Bookmark>.from(json["bookmarks"].map((x) => Bookmark.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "currentTime": currentTime,
    "questions": List<dynamic>.from(questions.map((x) => x)),
    "bookmarks": List<dynamic>.from(bookmarks.map((x) => x)),
  };
}

class Discussion {
  Discussion({
  required  this.discussionId,
  required  this.lectureId,
  required  this.timeline,
  });

  int discussionId;
  dynamic lectureId;
  dynamic timeline;

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
    discussionId: (json["discussionId"]!=null)?json["discussionId"]:-1,
    lectureId: json["lectureId"],
    timeline: json["timeline"],
  );

  Map<String, dynamic> toJson() => {
    "discussionId": discussionId,
    "lectureId": lectureId,
    "timeline": timeline,
  };
}
class Quizz {//
  Quizz({
  required  this.id,
  required  this.title,
  required  this.name,
  required  this.notes,
  required  this.questions,
  required  this.attendanceTable,
  });

  int id;
  dynamic title;
  String name;
  dynamic notes;
  List<Question> questions;
  List<QuizzAttendanceTable> attendanceTable;

  factory Quizz.fromJson(Map<String, dynamic> json) => Quizz(
    id: (json["id"]!=null)?json["id"]:-1,
    title: json["title"],
    name: (json["name"]!=null)?json["name"]:"",
    notes: json["notes"],
    questions: (json["questions"]!=null)?List<Question>.from(json["questions"].map((x) => Question.fromJson(x))):[],
    attendanceTable:(json["attendanceTable"]!=null)? List<QuizzAttendanceTable>.from(json["attendanceTable"].map((x) => QuizzAttendanceTable.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "name": name,
    "notes": notes,
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}


class QuizzAttendanceTable {
  QuizzAttendanceTable({
  required this.id,
  required this.userId,
  required this.attendedAt,
  required this.finished,
  required this.didPass,
  required this.totalDegree,
  required this.quizzId,
  required this.attendanceTable,
  });

  int id;
  dynamic userId;
  DateTime attendedAt;
  bool finished;
  bool didPass;
  double totalDegree;
  int quizzId;
  List<AttendanceTableAttendanceTable> attendanceTable;

  factory QuizzAttendanceTable.fromJson(Map<String, dynamic> json) => QuizzAttendanceTable(
    id: (json["id"]!=null)?json["id"]:-1,
    userId:( json["userId"]!=null)? json["userId"]:-1,
    attendedAt:(json["attendedAt"]!=null)? DateTime.parse(json["attendedAt"]):DateTime.now(),
    finished: (json["finished"]!=null)?json["finished"]:false,
    didPass: (json["didPass"]!=null)?json["didPass"]:false,
    totalDegree: (json["totalDegree"]!=null)?json["totalDegree"]:0.0,
    quizzId: (json["quizzId"]!=null)?json["quizzId"]:-1,
    attendanceTable:(json["attendanceTable"]!=null)? List<AttendanceTableAttendanceTable>.from(json["attendanceTable"].map((x) => AttendanceTableAttendanceTable.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "attendedAt": attendedAt.toIso8601String(),
    "finished": finished,
    "didPass": didPass,
    "totalDegree": totalDegree,
    "quizzId": quizzId,
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}
class AttendanceTableAttendanceTable {
  AttendanceTableAttendanceTable({
  required  this.id,
  required  this.questionId,
  required  this.answers,
  required  this.corrections,
  required  this.pairs,
  required  this.selected,
  required  this.words,
  required  this.degree,
  });

  int id;
  int questionId;
  List<CorrectionElement> answers;
  List<CorrectionElement> corrections;
  List<dynamic> pairs;
  dynamic selected;
  List<dynamic> words;
  double degree;

  factory AttendanceTableAttendanceTable.fromJson(Map<String, dynamic> json) => AttendanceTableAttendanceTable(
    id: (json["id"]!=null)?json["id"]:-1,
    questionId: (json["questionId"]!=null)?json["questionId"]:-1,
    answers:(json["answers"]!=null)? List<CorrectionElement>.from(json["answers"].map((x) => CorrectionElement.fromJson(x))):[],
    corrections: (json["corrections"]!=null)?List<CorrectionElement>.from(json["corrections"].map((x) => CorrectionElement.fromJson(x))):[],
    pairs:(json["pairs"]!=null)? List<dynamic>.from(json["pairs"].map((x) => x)):[],
    selected: json["selected"],
    words:(json["words"]!=null)? List<dynamic>.from(json["words"].map((x) => x)):[],
    degree: (json["degree"]!=null)?json["degree"]:0.0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionId": questionId,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    "corrections": List<dynamic>.from(corrections.map((x) => x.toJson())),
    "pairs": List<dynamic>.from(pairs.map((x) => x)),
    "selected": selected,
    "words": List<dynamic>.from(words.map((x) => x)),
    "degree": degree,
  };
}
class CorrectionElement {
  CorrectionElement({
  required  this.id,
  required  this.questionId,
  required  this.answerId,
  required  this.answer,
  required  this.explanation,
  required  this.isCorrect,
  });

  int id;
  int questionId;
  int answerId;
  String answer;
  String explanation;
  bool isCorrect;

  factory CorrectionElement.fromJson(Map<String, dynamic> json) => CorrectionElement(
    id: (json["id"]!=null)?json["id"]:-1,
    questionId: (json["questionId"]!=null)?json["questionId"]:-1,
    answerId: (json["answerId"]!=null)?json["answerId"]:-1,
    answer:( json["answer"]!=null)? json["answer"]:"",
    explanation: json["explanation"] == null ? "" : json["explanation"],
    isCorrect: json["isCorrect"] == null ? false : json["isCorrect"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "questionId": questionId,
    "answerId": answerId,
    "answer": answer,
    "explanation": explanation == null ? null : explanation,
    "isCorrect": isCorrect == null ? null : isCorrect,
  };
}

class Decision {
  Decision({
   required this.id,
   required this.title,
   required this.body,
   required this.attendanceTable,
  });

  int id;
  String title;
  String body;
  List<AttendanceTable> attendanceTable;

  factory Decision.fromJson(Map<String, dynamic> json) => Decision(
    id: (json["id"]!=null)?json["id"]:-1,
    title: (json["title"]!=null)?json["title"]:"",
    body: (json["body"]!=null)?json["body"]:"",
    attendanceTable:(json["attendanceTable"]!=null)? List<AttendanceTable>.from(json["attendanceTable"].map((x) => AttendanceTable.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}




// class MatchedAttendanceTable {
//   MatchedAttendanceTable({
//   required  this.id,
//   required  this.attendanceId,
//   required  this.pairId,
//   required  this.selectedId,
//   required  this.first,
//   required  this.second,
//   required  this.shouldBe,
//   required  this.attendance,
//   });
//
//   int id;
//   int attendanceId;
//   dynamic pairId;
//   dynamic selectedId;
//   String first;
//   String second;
//   String shouldBe;
//   dynamic attendance;
//
//   factory MatchedAttendanceTable.fromJson(Map<String, dynamic> json) => MatchedAttendanceTable(
//     id: json["id"],
//     attendanceId: json["attendanceId"],
//     pairId: json["pairId"],
//     selectedId: json["selectedId"],
//     first: json["first"],
//     second: json["second"],
//     shouldBe: json["shouldBe"],
//     attendance: json["attendance"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "attendanceId": attendanceId,
//     "pairId": pairId,
//     "selectedId": selectedId,
//     "first": first,
//     "second": second,
//     "shouldBe": shouldBe,
//     "attendance": attendance,
//   };
// }



