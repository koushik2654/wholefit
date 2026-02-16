import 'package:hive/hive.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 1)
class Workout {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int reps;

  @HiveField(2)
  final String bodyPart;

  @HiveField(3)
  final String equipment;

  @HiveField(4)
  final String gifUrl;

  Workout({
    required this.name,
    required this.reps,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
  });
}
