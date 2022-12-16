class Exercise {
  final String exerciseId;
  final String name;
  final String muscle;
  final String picture;

  const Exercise({
    required this.exerciseId,
    required this.name,
    required this.muscle,
    required this.picture,
  });

  static Exercise fromJson(json) => Exercise(
    exerciseId: json['exerciseId'],
    name: json['name'],
    muscle: json['muscle'],
    picture: json['picture'],
  );
}