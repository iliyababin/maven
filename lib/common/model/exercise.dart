class Exercise {
  final int exerciseId;
  final String name;
  final String muscle;
  final String picture;

  const Exercise({
    required this.exerciseId,
    required this.name,
    required this.muscle,
    required this.picture,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
    exerciseId: json["exerciseId"],
    name: json["name"],
    muscle: json["muscle"],
    picture: json["picture"],
  );

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'name': name,
      'muscle': muscle,
      'picture': picture,
    };
  }
}