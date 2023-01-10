class ExerciseGroup {
  int? exerciseGroupId;
  final int exerciseId;
  final int templateId;

  ExerciseGroup({
    this.exerciseGroupId,
    required this.exerciseId,
    required this.templateId,
  });

  factory ExerciseGroup.fromMap(Map<String, dynamic> json) {
    return ExerciseGroup(
      exerciseGroupId: json['exerciseGroupId'] ,
      exerciseId: json['exerciseId'],
      templateId: json['templateId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseGroupId': exerciseGroupId,
      'exerciseId': exerciseId,
      'templateId': templateId,
    };
  }
}