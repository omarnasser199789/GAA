class WordType4 {
  WordType4({
    required  this.id,
    required  this.attendanceId,
    required  this.word,
    required  this.order,
    required  this.correctOrder,
    required  this.correctWord,
  });

  int id;
  int attendanceId;
  int word;
  int order;
  int correctOrder;
  String correctWord;

  factory WordType4.fromJson(Map<String, dynamic> json) => WordType4(
    id: (json["id"]!=null)?json["id"]:-1,
    attendanceId: (json["attendanceId"]!=null)?json["attendanceId"]:-1,
    word: (json["word"]!=null)?json["word"]:-1,
    order:( json["order"]!=null)? json["order"]:-1,
    correctOrder: (json["correctOrder"]!=null)?json["correctOrder"]:-1,
    correctWord: (json["correctWord"]!=null)?json["correctWord"]:"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendanceId": attendanceId,
    "word": word,
    "order": order,
    "correctOrder": correctOrder,
    "correctWord": correctWord,
  };
}