class WordType3 {
  WordType3({
    required  this.questionId,
    required  this.word,
    required  this.order,
  });

  int questionId;
  int word;
  String order;

  factory WordType3.fromJson(Map<String, dynamic> json) => WordType3(
    questionId: json["questionId"],
    word: json["word"],
    order: (json["order"]!=null)?json["order"]:"",
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "word": word,
    "order": order,
  };
}