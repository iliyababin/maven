class Exercise {
  final int exerciseId;
  final String name;
  final String muscle;
  final String bodyPart;
  final String picture;

  const Exercise({
    required this.exerciseId,
    required this.name,
    required this.muscle,
    required this.bodyPart,
    required this.picture,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
    exerciseId: json["exerciseId"],
    name: json["name"],
    muscle: json["muscle"],
    bodyPart: json["bodyPart"],
    picture: json["picture"],
  );

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'name': name,
      'muscle': muscle,
      'bodyPart': bodyPart,
      'picture': picture,
    };
  }
}


