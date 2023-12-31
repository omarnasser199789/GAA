

class DogModel{
  final int id;
  final String name;
  final int age;

  const DogModel({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a DogModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each DogModel when using the print statement.
  @override
  String toString() {
    return 'DogModel{id: $id, name: $name, age: $age}';
  }
}