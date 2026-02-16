import 'package:hive/hive.dart';
import '../datasources/excercise_local_service.dart';
import '../models/exercise_model.dart';

class ExerciseRepository {
  final ExerciseLocalService localService = ExerciseLocalService();
  final Box<Exercise> exerciseBox = Hive.box<Exercise>('exerciseBox');

  Future<void> loadExercisesIfNeeded() async {
    if (exerciseBox.isNotEmpty) {
      print("Exercises already loaded from Hive.");
      return;
    }

    print("Loading exercises from local JSON…");

    final exercises = await localService.loadLocalExercises();

    exerciseBox.addAll(exercises);

    print("Saved ${exerciseBox.length} exercises to Hive.");
  }

  List<Exercise> getAllExercises() {
    return exerciseBox.values.toList();
  }
}
