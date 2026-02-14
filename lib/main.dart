import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/repositary/exercise_repository.dart';
import 'presentation/app.dart';
import 'data/models/workout_model.dart';
import 'data/models/exercise_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());

  // Open boxes
  await Hive.openBox<Workout>('workoutsBox');
  await Hive.openBox<Exercise>('exerciseBox');

  final exerciseRepo = ExerciseRepository();
  await exerciseRepo.loadExercisesIfNeeded();

  runApp(const GymApp());
}
