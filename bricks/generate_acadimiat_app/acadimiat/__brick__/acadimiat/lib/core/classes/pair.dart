class Pair {
  Pair({
    required  this.id,
    required  this.questionId,
    required  this.sentence,
  });

  int id;
  int questionId;
  String sentence;

  factory Pair.fromJson(Map<String, dynamic> json) => Pair(
    id: json["id"],
    questionId: json["questionId"],
    sentence: json["sentence"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionId": questionId,
    "sentence": sentence,
  };
}