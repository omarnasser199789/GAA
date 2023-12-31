class WordType2 {
  WordType2({
    required  this.wordId,
    required  this.questionId,
    required  this.word,
    required  this.order,
  });

  int wordId;
  int questionId;
  String word;
  dynamic order;

  factory WordType2.fromJson(Map<String, dynamic> json) => WordType2(
    wordId: (json["wordId"]!=null)?json["wordId"]:-1,
    questionId: (json["questionId"]!=null)?json["questionId"]:-1,
    word: (json["word"]!=null)?json["word"]:"",
    order: (json["order"]!=null)?json["order"]:null,
  );

  Map<String, dynamic> toJson() => {
    "wordId": wordId,
    "questionId": questionId,
    "word": word,
    "order": order,
  };
}