class Matched {
  Matched({
    required  this.id,
    required  this.attendanceId,
    required  this.pairId,
    required  this.selectedId,
    required  this.first,
    required  this.second,
    required  this.shouldBe,
    required  this.attendance,
  });

  int id;
  int attendanceId;
  dynamic pairId;
  dynamic selectedId;
  String first;
  String second;
  String shouldBe;
  dynamic attendance;

  factory Matched.fromJson(Map<String, dynamic> json) => Matched(
    id: (json["id"]!=null)?json["id"]:-1,
    attendanceId: (json["attendanceId"]!=null)?json["attendanceId"]:-1,
    pairId: json["pairId"],
    selectedId: json["selectedId"],
    first: (json["first"]!=null)?json["first"]:"",
    second: (json["second"]!=null)?json["second"]:"",
    shouldBe: (json["shouldBe"]!=null)?json["shouldBe"]:"",
    attendance: json["attendance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendanceId": attendanceId,
    "pairId": pairId,
    "selectedId": selectedId,
    "first": first,
    "second": second,
    "shouldBe": shouldBe,
    "attendance": attendance,
  };
}