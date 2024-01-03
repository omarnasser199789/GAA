import 'package:acadmiat/core/classes/pair.dart';
import 'package:acadmiat/core/classes/word_type2.dart';

class Question {
  Question({
    required  this.id,
    required  this.quizzId,
    required  this.questionType,
    required  this.score,
    required  this.optional,
    required  this.question,
    required  this.title,
    required  this.stripped,
    required  this.words,
    required  this.answer,
    required  this.pairs,
    required  this.pairsSelection,
  });

  int id;
  int quizzId;
  int questionType;
  int score;
  bool optional;
  String question;
  String title;
  dynamic stripped;
  List<WordType2> words;
  List<Answer> answer;
  List<Pair> pairs;
  List<Pair> pairsSelection;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: (json["id"]!=null)?json["id"]:-1,
    quizzId:( json["quizzId"]!=null)? json["quizzId"]:-1,
    questionType: (json["questionType"]!=null)?json["questionType"]:-1,
    score: (json["score"]!=null)?json["score"]:0,
    optional: (json["optional"]!=null)?json["optional"]:false,
    question: (json["question"]!=null)?json["question"]:"",
    title: (json["title"]!=null)?json["title"]:"",
    stripped: json["stripped"],
      words:(json["words"]!=null)? List<WordType2>.from(json["words"].map((x) => WordType2.fromJson(x))):[],
      answer:(json["answer"]!=null)? List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x))):[],
      pairs: (json["pairs"]!=null)?List<Pair>.from(json["pairs"].map((x) => Pair.fromJson(x))):[],
      pairsSelection: (json["pairsSelection"]!=null)?List<Pair>.from(json["pairsSelection"].map((x) => Pair.fromJson(x))):[]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quizzId": quizzId,
    "questionType": questionType,
    "score": score,
    "optional": optional,
    "question": question,
    "title": title,
    "stripped": stripped,
    "words": List<dynamic>.from(words.map((x) => x)),
    "answer": List<dynamic>.from(answer.map((x) => x.toJson())),
    "pairs": List<dynamic>.from(pairs.map((x) => x)),
    "pairsSelection": List<dynamic>.from(pairsSelection.map((x) => x)),
  };
}
class Answer {
  Answer({
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
  dynamic explanation;
  dynamic isCorrect;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: (json["id"]!=null)?json["id"]:-1,
    questionId: (json["questionId"]!=null)?json["questionId"]:-1,
    answerId:( json["answerId"]!=null)? json["answerId"]:-1,
    answer: (json["answer"]!=null)?json["answer"]:"",
    explanation: json["explanation"],
    isCorrect: json["isCorrect"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionId": questionId,
    "answerId": answerId,
    "answer": answer,
    "explanation": explanation,
    "isCorrect": isCorrect,
  };
}


