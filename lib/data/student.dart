class Student {
  int? id;
  final String name;
  final int age;

  Student({required this.name, required this.age});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      age: json['age'],
    );
  }
}
