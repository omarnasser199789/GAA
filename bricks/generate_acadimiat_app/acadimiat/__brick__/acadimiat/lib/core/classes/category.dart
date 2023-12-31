class Category {
  Category({
   required this.id,
   required this.courseId,
   required this.categoryId,
    required this.courseName,
    required this.categoryName,
  });

  int id;
  int courseId;
  int categoryId;
  String courseName;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? -1,
    courseId: json["courseId"] ?? -1,
    categoryId: json["categoryId"] ?? -1,
    courseName: json["courseName"] ?? "",
    categoryName: json["categoryName"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseId": courseId,
    "categoryId": categoryId,
    "courseName": courseName,
    "categoryName": categoryName,
  };
}