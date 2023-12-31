// To parse this JSON data, do
//
//     final MyCourseModel = MyCourseModelFromJson(jsonString);

import 'dart:convert';

import 'package:acadmiat/features/my_courses_feature/domain/entities/my_course_entity.dart';

MyCourseModel MyCourseModelFromJson(String str) => MyCourseModel.fromJson(json.decode(str));

String MyCourseModelToJson(MyCourseModel data) => json.encode(data.toJson());

class MyCourseModel extends MyCourseEntity {
  MyCourseModel({
  required  this.id,
  required  this.courseName,
  required  this.preCourseQuizzId,
  required  this.courseLink,
  required  this.progress,
  required  this.courseCover,
  required  this.courseVideo,
  required  this.courseRecord,
  required  this.trainers,
  required  this.courseContents,
  required  this.quizz,
  required  this.currentLecture,
  required  this.assignments,
  required  this.wiki,
  required  this.forum,
  required  this.glossary,
  required  this.caseStudy,
  }):super(
    id: id,
    courseName: courseName,
    preCourseQuizzId: preCourseQuizzId,
    courseLink: courseLink,
     progress: progress,
    courseCover: courseCover,
    courseVideo: courseVideo,
    courseRecord: courseRecord,
    trainers: trainers,
    courseContents: courseContents,
    quizz: quizz,
    currentLecture: currentLecture,
    assignments: assignments,
    wiki: wiki,
    forum: forum,
    glossary: glossary,
    caseStudy: caseStudy,

  );

  int id;
  String courseName;
  int preCourseQuizzId;
  String courseLink;
  int progress;
  String courseCover;
  dynamic courseVideo;
  CourseRecord courseRecord;
  List<Trainer> trainers;
  List<CourseContent> courseContents;
  List<Quizz> quizz;
  dynamic currentLecture;
  List<Assignment> assignments;
  Wiki wiki;
  Forum forum;
  Glossary glossary;
  List<CaseStudy> caseStudy;

  factory MyCourseModel.fromJson(Map<String, dynamic> json) => MyCourseModel(
    id: (json["id"]!=null)?json["id"]:-1,
    courseName: (json["courseName"]!=null)?json["courseName"]:"",
    preCourseQuizzId: (json["preCourseQuizzId"]!=null)?json["preCourseQuizzId"]:-1,
    courseLink: (json["courseLink"]!=null)?json["courseLink"]:"",
    progress: (json["progress"]!=null)?json["progress"]:-1,
    courseCover: (json["courseCover"]!=null)?json["courseCover"]:"",
    courseVideo: (json["courseVideo"]!=null)?json["courseVideo"]:null,
    courseRecord:
    (json["courseRecord"]!=null)?
    CourseRecord.fromJson(json["courseRecord"])
          :

    CourseRecord(id: -1,traineeId: -1 ,courseId: -1, isFinished: false,currentProgress: 0.0,  completedAt: null,
         activitiesLog: [],unitsLog: [], )
  ,


    trainers:
    (json["trainers"]!=null)?
    List<Trainer>.from(json["trainers"].map((x) => Trainer.fromJson(x)))
        :[]
    ,
    courseContents:
    (json["courseContents"]!=null)?
    List<CourseContent>.from(json["courseContents"].map((x) => CourseContent.fromJson(x)))
        :[]
    ,
    quizz:
    (json["quizz"]!=null)?
    List<Quizz>.from(json["quizz"].map((x) => Quizz.fromJson(x)))
        :[]
    ,
    currentLecture:
    (json["currentLecture"]!=null)?
    json["currentLecture"]
        :null
    ,
    assignments:(json["assignments"]!=null)? List<Assignment>.from(json["assignments"].map((x) => Assignment.fromJson(x))):[],

    wiki:(json["wiki"]!=null)? Wiki.fromJson(json["wiki"]):
    Wiki(articles: [], wikiName: "", wikiId: -1),


    forum:
    (json["forum"]!=null)?
    Forum.fromJson(json["forum"])
        :
    Forum(forumName: null,
        toDate: null,
        fromDate: null,
        topics: [],
        description: null,
        forumId: -1)
    ,
    glossary:
    (json["glossary"]!=null)?
    Glossary.fromJson(json["glossary"])
          :
    Glossary(numberOfConcepts: -1,
        glossaryId: -1,
        description: null,
        name: null, concepts: [])
  ,

    caseStudy: List<CaseStudy>.from(json["caseStudy"].map((x) => CaseStudy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseName": courseName,
    "preCourseQuizzId": preCourseQuizzId,
    "courseLink": courseLink,
    "progress": progress,
    "courseCover": courseCover,
    "courseVideo": courseVideo,
    "courseRecord": courseRecord.toJson(),
    "trainers": List<dynamic>.from(trainers.map((x) => x.toJson())),
    "courseContents": List<dynamic>.from(courseContents.map((x) => x.toJson())),
    "quizz": List<dynamic>.from(quizz.map((x) => x.toJson())),
    "currentLecture": currentLecture,
    "assignments": List<dynamic>.from(assignments.map((x) => x.toJson())),
    "wiki": wiki.toJson(),
    "forum": forum.toJson(),
    "glossary": glossary.toJson(),
    "caseStudy": List<dynamic>.from(caseStudy.map((x) => x.toJson())),

  };
}
class CaseStudy {
  CaseStudy({
 required this.casestudyId,
 required this.open,
 required this.header,
 required this.body,
 required this.solution,
  this.attendanceTable,
  });

  int casestudyId;
  bool open;
  String header;
  String body;
  Solution solution;
  List<AttendanceTable> ? attendanceTable;

  factory CaseStudy.fromJson(Map<String, dynamic> json) => CaseStudy(
    casestudyId: (json["casestudyId"]!=null)?json["casestudyId"]:-1,
    open: (json["open"]!=null)?json["open"]:false,
    header: (json["header"]!=null)?json["header"]:"",
    body: (json["body"]!=null)?json["body"]:"",
    solution: (json["solution"]!=null)?Solution.fromJson(json["solution"]):Solution(solutionId: -1, answers: []),
    attendanceTable: (json["attendanceTable"]!=null)?json["attendanceTable"]:[],
  );

  Map<String, dynamic> toJson() => {
    "casestudyId": casestudyId,
    "open": open,
    "header": header,
    "body": body,
    "solution": solution.toJson(),
    "attendanceTable": attendanceTable,
  };
}
class Solution {
  Solution({
   required this.solutionId,
   required this.answers,
  });

  int solutionId;
  List<Answer> answers;

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
    solutionId: json["solutionId"],
    answers:(json["answers"]!=null)? List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "solutionId": solutionId,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}
class Answer {
  Answer({
  required  this.answerId,
  required  this.answer,
  required  this.explain,
  });

  int answerId;
  String answer;
  dynamic explain;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    answerId: json["answerId"],
    answer: json["answer"] ?? "",
    explain: json["explain"],
  );

  Map<String, dynamic> toJson() => {
    "answerId": answerId,
    "answer": answer == null ? null : answer,
    "explain": explain,
  };
}

class Assignment {
  Assignment({
  required  this.id,
  required  this.assignemnet,
  required  this.body,
  required  this.file,
  required  this.year,
    this.isDone,
  required  this.rule,
  required  this.appliedAt,
  required  this.notes,
  required  this.fromDate,
  required  this.toDate,
  });

  int id;
  String assignemnet;
  String body;
  String file;
  int year;
  bool ? isDone;
  String rule;
  DateTime appliedAt;
  String notes;
  DateTime fromDate;
  DateTime toDate;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: (json["id"]!=null)?json["id"]:-1,
    assignemnet: (json["assignemnet"]!=null)?json["assignemnet"]:"",
    body: (json["body"]!=null)?json["body"]:"",
    file: (json["file"]!=null)?json["file"]:"",
    year: (json["year"]!=null)?json["year"]:0,
    isDone:json["isDone"],
    rule: (json["rule"]!=null)?json["rule"]:"",
    appliedAt:(json["appliedAt"]!=null)? DateTime.parse(json["appliedAt"]):DateTime.now(),
    notes: json["notes"] == null ? "" : json["notes"],
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assignemnet": assignemnet,
    "body": body,
    "file": file,
    "year": year,
    "isDone": isDone,
    "rule": rule,
    "appliedAt": appliedAt.toIso8601String(),
    "notes": notes == null ? null : notes,
    "fromDate": fromDate.toIso8601String(),
    "toDate": toDate.toIso8601String(),
  };
}
class CourseContent {
  CourseContent({
  required this.id,
  required this.unitName,
  required this.unitDesc,
  required this.unitBanner,
  required this.isDone,
  required this.percent,
  required this.totalScore,
  required this.completitionDate,
  required this.contents,
  required this.quizz,
  });

  int id;
  String unitName;
  String unitDesc;
  String unitBanner;
  bool isDone;
  double percent;
  double totalScore;
  dynamic completitionDate;
  List<Content> contents;
  Quizz quizz;

  factory CourseContent.fromJson(Map<String, dynamic> json) => CourseContent(
    id: (json["id"]!=null)?json["id"]:-1,
    unitName:( json["unitName"]!=null)? json["unitName"]:"",
    unitDesc: (json["unitDesc"]!=null)?json["unitDesc"]:"",
    unitBanner: (json["unitBanner"]!=null)?json["unitBanner"]:"",
    isDone: (json["isDone"]!=null)?json["isDone"]:false,
    percent:( json["percent"]!=null) ?json["percent"]:0.0,
    totalScore: (json["totalScore"]!=null)?json["totalScore"]:0.0,
    completitionDate: (json["completitionDate"]!=null)?json["completitionDate"]:null,
    contents: (json["contents"]!=null)?List<Content>.from(json["contents"].map((x) => Content.fromJson(x))):[],

    quizz:(json["quizz"]!=null)? Quizz.fromJson(json["quizz"]):Quizz(quizzName: '', attempts: -1, quizzId: -1),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unitName": unitName,
    "unitDesc": unitDesc,
    "unitBanner": unitBanner,
    "isDone": isDone,
    "percent": percent,
    "totalScore": totalScore,
    "completitionDate": completitionDate,
    "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
    "quizz": quizz.toJson(),
  };
}

class Content {
  Content({
  required  this.id,
  required  this.name,
  required  this.type,
  required  this.isDone,
  required  this.lectureContents,
  });

  int id;
  String name;
  int type;
  bool isDone;
  List<LectureContent> lectureContents;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: (json["id"]!=null)?json["id"]:-1,
    name: (json["name"]!=null)?json["name"]:"",
    type: (json["type"]!=null)?json["type"]:-1,
    isDone: (json["isDone"]!=null)?json["isDone"]:false,
    lectureContents:(json["lectureContents"])!=null ?List<LectureContent>.from(json["lectureContents"].map((x) => LectureContent.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "isDone": isDone,
    "lectureContents": List<dynamic>.from(lectureContents.map((x) => x.toJson())),
  };
}

class LectureContent {
  LectureContent({
  required  this.id,
  required  this.type,
  required  this.title,
  required  this.time,
  });

  int id;
  int type;
  String title;
  double time;

  factory LectureContent.fromJson(Map<String, dynamic> json) => LectureContent(
    id: (json["id"]!=null)?json["id"]:-1,
    type: (json["type"]!=null)?json["type"]:-1,
    title: (json["title"]!=null)?json["title"]:"",
    time: (json["time"]!=null)?json["time"]:0.0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "time": time,
  };
}

class Quizz {
  Quizz({
  required  this.quizzId,
  required  this.quizzName,
  required  this.attempts,
  });

  int quizzId;
  String quizzName;
  int attempts;

  factory Quizz.fromJson(Map<String, dynamic> json) => Quizz(
    quizzId: (json["quizzId"]!=null)?json["quizzId"]:-1,
    quizzName: (json["quizzName"]!=null)?json["quizzName"]:"",
    attempts: (json["attempts"]!=null)?json["attempts"]:0,
  );

  Map<String, dynamic> toJson() => {
    "quizzId": quizzId,
    "quizzName": quizzName,
    "attempts": attempts,
  };
}

class CourseRecord {
  CourseRecord({
   required this.id,
   required this.traineeId,
   required this.courseId,
   required this.isFinished,
   required this.currentProgress,
   required this.completedAt,
   required this.unitsLog,
   required this.activitiesLog,
  });

  int id;
  int traineeId;
  int courseId;
  bool isFinished;
  double currentProgress;
  dynamic completedAt;
  List<UnitsLog> unitsLog;
  List<dynamic> activitiesLog;

  factory CourseRecord.fromJson(Map<String, dynamic> json) => CourseRecord(
    id: (json["id"]!=null)?json["id"]:-1,
    traineeId: (json["traineeId"]!=null)?json["traineeId"]:-1,
    courseId: (json["courseId"]!=null)?json["courseId"]:-1,
    isFinished: (json["isFinished"]!=null)?json["isFinished"]:false,
    currentProgress: (json["currentProgress"]!=null)?json["currentProgress"]:0.0,
    completedAt:( json["completedAt"]!=null)? json["completedAt"]:DateTime.now(),
    unitsLog:(json["unitsLog"]!=null)? List<UnitsLog>.from(json["unitsLog"].map((x) => UnitsLog.fromJson(x))):[],
    activitiesLog:(json["activitiesLog"]!=null)?List<dynamic>.from(json["activitiesLog"].map((x) => x)):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "traineeId": traineeId,
    "courseId": courseId,
    "isFinished": isFinished,
    "currentProgress": currentProgress,
    "completedAt": completedAt,
    "unitsLog": List<dynamic>.from(unitsLog.map((x) => x.toJson())),
    "activitiesLog": List<dynamic>.from(activitiesLog.map((x) => x)),
  };
}

class UnitsLog {
  UnitsLog({
  required  this.id,
  required  this.traineeId,
  required  this.unitId,
  required  this.courselogId,
  required  this.isFinished,
  required  this.currentProgress,
  required  this.completedAt,
  required  this.lecturesLog,
  required  this.quizzesLog,
  });

  int id;
  int traineeId;
  int unitId;
  int courselogId;
  bool isFinished;
  double currentProgress;
  dynamic completedAt;
  List<LecturesLog> lecturesLog;
  List<dynamic> quizzesLog;

  factory UnitsLog.fromJson(Map<String, dynamic> json) => UnitsLog(
    id: (json["id"]!=null)?json["id"]:-1,
    traineeId: (json["traineeId"]!=null)?json["traineeId"]:-1,
    unitId: (json["unitId"]!=null)?json["unitId"]:-1,
    courselogId:( json["courselogId"]!=null)? json["courselogId"]:-1,
    isFinished: (json["isFinished"]!=null)?json["isFinished"]:false,
    currentProgress: (json["currentProgress"]!=null)?json["currentProgress"]:0.0,
    completedAt:( json["completedAt"]!=null)? json["completedAt"]:null,
    lecturesLog: (json["lecturesLog"]!=null)?List<LecturesLog>.from(json["lecturesLog"].map((x) => LecturesLog.fromJson(x))):[],
    quizzesLog:(json["quizzesLog"]!=null)? List<dynamic>.from(json["quizzesLog"].map((x) => x)):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "traineeId": traineeId,
    "unitId": unitId,
    "courselogId": courselogId,
    "isFinished": isFinished,
    "currentProgress": currentProgress,
    "completedAt": completedAt,
    "lecturesLog": List<dynamic>.from(lecturesLog.map((x) => x.toJson())),
    "quizzesLog": List<dynamic>.from(quizzesLog.map((x) => x)),
  };
}

class LecturesLog {
  LecturesLog({
  required  this.id,
  required  this.traineeId,
  required  this.lectureId,
  required  this.unitlogId,
  required  this.isFinished,
  required  this.currentProgress,
  required  this.completedAt,
  });

  int id;
  int traineeId;
  int lectureId;
  int unitlogId;
  bool isFinished;
  double currentProgress;
  DateTime completedAt;

  factory LecturesLog.fromJson(Map<String, dynamic> json) => LecturesLog(
    id: (json["id"]!=null)?json["id"]:-1,
    traineeId: (json["traineeId"]!=null)?json["traineeId"]:-1,
    lectureId: (json["lectureId"]!=null)?json["lectureId"]:-1,
    unitlogId: (json["unitlogId"]!=null)?json["unitlogId"]:-1,
    isFinished: (json["isFinished"]!=null)?json["isFinished"]:false,
    currentProgress: (json["currentProgress"]!=null)?json["currentProgress"]:0.0,
    completedAt: (json["completedAt"] != null) ? DateTime.parse(json["completedAt"]):DateTime.now()  ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "traineeId": traineeId,
    "lectureId": lectureId,
    "unitlogId": unitlogId,
    "isFinished": isFinished,
    "currentProgress": currentProgress,
    "completedAt": completedAt == null ? null : completedAt.toIso8601String(),
  };
}

class Forum {
  Forum({
  required  this.forumId,
  required  this.forumName,
  required  this.description,
  required  this.fromDate,
  required  this.toDate,
  required  this.topics,
  });

  int forumId;
  dynamic forumName;
  dynamic description;
  dynamic fromDate;
  dynamic toDate;
  List<Topic> topics;

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
    forumId: (json["forumId"]!=null)?json["forumId"]:-1,
    forumName: (json["forumName"]!=null)?json["forumName"]:"",
    description: (json["description"]!=null)?json["description"]:"",
    fromDate: (json["fromDate"]!=null)?json["fromDate"]:null,
    toDate:(json["toDate"]!=null)? json["toDate"]:null,
    topics:(json["topics"]!=null)? List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "forumId": forumId,
    "forumName": forumName,
    "description": description,
    "fromDate": fromDate,
    "toDate": toDate,
    "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
  };
}
class Topic {
  Topic({
  required  this.topicId,
  required  this.addedBy,
  required  this.topic,
  required  this.attachment,
  required  this.date,
  required  this.replies,
  });

  int topicId;
  String addedBy;
  String topic;
  String attachment;
  DateTime date;
  List<Reply> replies;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    topicId: json["topicId"],
    addedBy: json["addedBy"],
    topic: json["topic"],
    attachment: json["attachment"],
    date: DateTime.parse(json["date"]),
    replies: List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "topicId": topicId,
    "addedBy": addedBy,
    "topic": topic,
    "attachment": attachment,
    "date": date.toIso8601String(),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
  };
}


class Reply {
  Reply({
  required  this.replyId,
  required  this.addedBy,
  required  this.reply,
  required  this.attachment,
  required  this.date,
  });

  int replyId;
  String addedBy;
  String reply;
  dynamic attachment;
  DateTime date;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    replyId: json["replyId"],
    addedBy: json["addedBy"],
    reply: json["reply"],
    attachment: json["attachment"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "replyId": replyId,
    "addedBy": addedBy,
    "reply": reply,
    "attachment": attachment,
    "date": date.toIso8601String(),
  };
}

class Glossary {
  Glossary({
  required  this.glossaryId,
  required  this.name,
  required  this.description,
  required  this.numberOfConcepts,
  required  this.concepts,
  });

  int glossaryId;
  dynamic name;
  dynamic description;
  int numberOfConcepts;
  List<Concept> concepts;

  factory Glossary.fromJson(Map<String, dynamic> json) => Glossary(
    glossaryId: (json["glossaryId"]!=null)?json["glossaryId"]:-1,
    name:( json["name"]!=null)? json["name"]:"",
    description: (json["description"]!=null)?json["description"]:"",
    numberOfConcepts: (json["numberOfConcepts"]!=null)?json["numberOfConcepts"]:-1,
    concepts:(json["concepts"]!=null)?
    List<Concept>.from(json["concepts"].map((x) => Concept.fromJson(x))):[],

  );

  Map<String, dynamic> toJson() => {
    "glossaryId": glossaryId,
    "name": name,
    "description": description,
    "numberOfConcepts": numberOfConcepts,
    "concepts": List<dynamic>.from(concepts.map((x) => x.toJson())),
  };
}


class Concept {
  Concept({
  required  this.conceptId,
  required  this.addedBy,
  required  this.concept,
  required  this.file,
  required  this.definition,
  required  this.keywords,
  required  this.attachment,
  required  this.date,
  });

  int conceptId;
  String addedBy;
  String concept;
  dynamic file;
  String definition;
  String keywords;
  dynamic attachment;
  DateTime date;

  factory Concept.fromJson(Map<String, dynamic> json) => Concept(
    conceptId: json["conceptId"],
    addedBy: json["addedBy"],
    concept: json["concept"],
    file: json["file"],
    definition: json["definition"],
    keywords: json["keywords"],
    attachment: json["attachment"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "conceptId": conceptId,
    "addedBy": addedBy,
    "concept": concept,
    "file": file,
    "definition": definition,
    "keywords": keywords,
    "attachment": attachment,
    "date": date.toIso8601String(),
  };
}


class Trainer {
  Trainer({
  required  this.id,
  required  this.trainerName,
  required  this.trainerInfo,
  required  this.trainerAvatar,
  required  this.trainerMoreInfo,
  required  this.trainerCourses,
  });

  int id;
  String trainerName;
  String trainerInfo;
  String trainerAvatar;
  String trainerMoreInfo;
  dynamic trainerCourses;

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
    id: (json["id"]!=null)?json["id"]:-1,
    trainerName: (json["trainerName"]!=null)?json["trainerName"]:"",
    trainerInfo: (json["trainerInfo"]!=null)?json["trainerInfo"]:"",
    trainerAvatar: (json["trainerAvatar"]!=null)?json["trainerAvatar"]:"",
    trainerMoreInfo: (json["trainerMoreInfo"]!=null)?json["trainerMoreInfo"]:"",
    trainerCourses: (json["trainerCourses"]!=null)?json["trainerCourses"]:null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trainerName": trainerName,
    "trainerInfo": trainerInfo,
    "trainerAvatar": trainerAvatar,
    "trainerMoreInfo": trainerMoreInfo,
    "trainerCourses": trainerCourses,
  };
}

class Wiki {
  Wiki({
  required  this.wikiId,
  required  this.wikiName,
  required  this.articles,
  });

  int wikiId;
  String wikiName;
  List<Article> articles;

  factory Wiki.fromJson(Map<String, dynamic> json) => Wiki(
    wikiId: (json["wikiId"]!=null)?json["wikiId"]:-1,
    wikiName: (json["wikiName"]!=null)?json["wikiName"]:"",
    articles: (json["articles"]!=null)?List<Article>.from(json["articles"].map((x) => Article.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "wikiId": wikiId,
    "wikiName": wikiName,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  Article({
  required  this.articleId,
  required  this.articleName,
  required  this.addedBy,
  required  this.date,
  required  this.details,
  });

  int articleId;
  String articleName;
  String addedBy;
  DateTime date;
  List<Detail> details;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    articleId: (json["articleId"]!=null)?json["articleId"]:-1,
    articleName:( json["articleName"]!=null)? json["articleName"]:"",
    addedBy:(json["addedBy"]!=null)?json["addedBy"]:"",
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
    details:(json["details"]!=null)? List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "articleId": articleId,
    "articleName": articleName,
    "addedBy": addedBy,
    "date": date.toIso8601String(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
  required  this.detailId,
  required  this.addedBy,
  required  this.header,
  required  this.body,
  required  this.date,
  });

  int detailId;
  String addedBy;
  String header;
  String body;
  DateTime date;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    detailId: (json["detailId"]!=null)?json["detailId"]:-1,
    addedBy: (json["addedBy"]!=null)?json["addedBy"]:"",
    header: (json["header"]!=null)?json["header"]:"",
    body: (json["body"]!=null)?json["body"]:"",
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "detailId": detailId,
    "addedBy": addedBy,
    "header": header,
    "body": body,
    "date": date.toIso8601String(),
  };
}


class AttendanceTable {
  AttendanceTable({
    required  this.id,
    required  this.userId,
  required  this.decisionId,
  required  this.repliedAt,

  required  this.attendanceAt,
  required  this.opinion,
  required  this.comments,
  });

  int id;
  dynamic decisionId;
  DateTime repliedAt;
  int userId;
  DateTime attendanceAt;
  String opinion;
  List<dynamic> comments;

  factory AttendanceTable.fromJson(Map<String, dynamic> json) => AttendanceTable(
    id: (json["id"]!=null)?json["id"]:-1,
    decisionId:( json["decisionId"]!=null)? json["decisionId"]:-1,
    repliedAt:(json["repliedAt"])? DateTime.parse(json["repliedAt"]):DateTime.now(),
    userId: (json["userId"]!=null)?json["userId"]:-1,
    attendanceAt:(json["attendanceAt"]!=null)? DateTime.parse(json["attendanceAt"]):DateTime.now(),
    opinion: (json["opinion"]!=null)?json["opinion"]:"",
    comments:(json["comments"]!=null)? List<dynamic>.from(json["comments"].map((x) => x)):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "decisionId": decisionId,
    "repliedAt": repliedAt.toIso8601String(),
    "userId": userId,
    "attendanceAt": attendanceAt.toIso8601String(),
    "opinion": opinion,
    "comments": List<dynamic>.from(comments.map((x) => x)),
  };
}



