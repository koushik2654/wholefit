import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'data/repositary/exercise_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'presentation/app.dart';
import 'data/models/workout_model.dart';
import 'data/models/exercise_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://lukqwotdfgfiecfwtsxj.supabase.co',
    anonKey: 'sb_publishable_1dcdaEAR-r0tRsSc6B_0KQ_hEXZ7khO',
  );
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());

  // Open boxes
  await Hive.openBox<Workout>('workoutsBox');
  await Hive.openBox<Exercise>('exerciseBox');

  final exerciseRepo = ExerciseRepository();
  await exerciseRepo.loadExercisesIfNeeded();

  runApp(
    BlocProvider(
      create: (_) => AuthBloc(),
      child: const GymApp(),
    ),
  );
}