import 'package:acadmiat/features/my_courses_feature/domain/repositories/consultations_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'dart:convert';


class SubmitQuizUseCase implements UseCase<int, SubmitQuizParams> {
  final MyCoursesRepository repository;
  SubmitQuizUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(SubmitQuizParams params) {
    return repository.submitQuiz(params);
  }
}

class SubmitQuizParams{
  SubmitQuiz submitQuiz;
  String connectionId;
  SubmitQuizParams({
    required this.submitQuiz,
    required this.connectionId,
});
}


SubmitQuiz SubmitQuizFromJson(String str) => SubmitQuiz.fromJson(json.decode(str));

String SubmitQuizToJson(SubmitQuiz data) => json.encode(data.toJson());

class SubmitQuiz {
  SubmitQuiz({
  required  this.userId,
  required  this.attendedAt,
  required  this.finished,
  required  this.quizzId,
  required  this.attendanceTable,
  });

  int userId;
  DateTime attendedAt;
  bool finished;
  int quizzId;
  List<AttendanceTable> attendanceTable;

  factory SubmitQuiz.fromJson(Map<String, dynamic> json) => SubmitQuiz(
    userId: json["userId"],
    attendedAt: DateTime.parse(json["attendedAt"]),
    finished: json["finished"],
    quizzId: json["quizzId"],
    attendanceTable: List<AttendanceTable>.from(json["attendanceTable"].map((x) => AttendanceTable.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "attendedAt": attendedAt.toIso8601String(),
    "finished": finished,
    "quizzId": quizzId,
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}

class AttendanceTable {
  AttendanceTable({
  required  this.questionId,
  required  this.givenAnswers,
  required  this.givenWords,
  required  this.pairs,
  });

  int questionId;
  List<GivenAnswer> givenAnswers;
  List<GivenWord> givenWords;
  List<Pair> pairs;

  factory AttendanceTable.fromJson(Map<String, dynamic> json) => AttendanceTable(
    questionId: json["questionId"],
    givenAnswers: List<GivenAnswer>.from(json["givenAnswers"].map((x) => GivenAnswer.fromJson(x))),
    givenWords: List<GivenWord>.from(json["givenWords"].map((x) => GivenWord.fromJson(x))),
    pairs: List<Pair>.from(json["pairs"].map((x) => Pair.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "givenAnswers": List<dynamic>.from(givenAnswers.map((x) => x.toJson())),
    "givenWords": List<dynamic>.from(givenWords.map((x) => x.toJson())),
    "pairs": List<dynamic>.from(pairs.map((x) => x.toJson())),
  };
}

class GivenAnswer {
  GivenAnswer({
  required  this.questionId,
  required  this.answerId,
  });

  int questionId;
  int answerId;

  factory GivenAnswer.fromJson(Map<String, dynamic> json) => GivenAnswer(
    questionId: json["questionId"],
    answerId: json["answerId"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "answerId": answerId,
  };
}
class GivenWord {
  GivenWord({
  required  this.questionId,
  required  this.word,
    this.order,
  });

  int questionId;
  int word;
  int ? order;

  factory GivenWord.fromJson(Map<String, dynamic> json) => GivenWord(
    questionId: json["questionId"],
    word: json["word"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "word": word,
    "order": order,
  };
}
class Pair {
  Pair({
  required  this.questionId,
  required  this.pairId,
  required  this.selectedId,
  });

  int questionId;
  int pairId;
  int selectedId;

  factory Pair.fromJson(Map<String, dynamic> json) => Pair(
    questionId: json["questionId"],
    pairId: json["pairId"],
    selectedId: json["selectedId"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "pairId": pairId,
    "selectedId": selectedId,
  };
}

