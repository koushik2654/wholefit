import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 2)
class Exercise {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String bodyPart;

  @HiveField(3)
  final String target;

  @HiveField(4)
  final String equipment;

  @HiveField(5)
  final String gifUrl;

  Exercise({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.target,
    required this.equipment,
    required this.gifUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      bodyPart: json["bodyPart"] ?? "",
      target: json["target"] ?? "",
      equipment: json["equipment"] ?? "",
      gifUrl: json["gifUrl"] ?? "",
    );
  }
}
