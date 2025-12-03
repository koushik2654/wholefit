import 'package:hive/hive.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 1)
class Workout {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int reps;

  // You can add more fields later (category, timestamp)

  Workout({
    required this.name,
    required this.reps,
  });
}
