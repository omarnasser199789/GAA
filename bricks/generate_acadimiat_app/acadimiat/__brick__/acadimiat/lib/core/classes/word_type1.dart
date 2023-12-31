class WordType1 {
  WordType1({
    required this.id,
    required this.word,
  });

  int id;
  String word;

  factory WordType1.fromJson(Map<String, dynamic> json) => WordType1(
    id: json["id"],
    word: (json["word"]!=null)?json["word"]:"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "word": word,
  };
}