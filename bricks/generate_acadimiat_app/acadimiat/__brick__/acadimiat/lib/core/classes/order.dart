class Order {
  Order({
    required  this.id,
    required  this.sentenceId,
    required  this.order,
    required  this.correct,
  });

  int id;
  int sentenceId;
  int order;
  int correct;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    sentenceId: json["sentenceId"],
    order: json["order"],
    correct: json["correct"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sentenceId": sentenceId,
    "order": order,
    "correct": correct,
  };
}