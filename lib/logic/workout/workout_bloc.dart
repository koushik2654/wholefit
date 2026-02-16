import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../data/models/workout_model.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final Box<Workout> workoutsBox = Hive.box<Workout>('workoutsBox');

  WorkoutBloc() : super(const WorkoutState()) {

    // Load workouts from Hive
    on<LoadWorkouts>((event, emit) {
      final storedWorkouts = workoutsBox.values.toList();
      emit(state.copyWith(workouts: storedWorkouts));
    });

    // Add new workout
    on<AddWorkout>((event, emit) {
      final exercise = event.exercise;

      final newWorkout = Workout(
        name: exercise.name,
        reps: event.reps,
        bodyPart: exercise.bodyPart,
        equipment: exercise.equipment,
        gifUrl: exercise.gifUrl,
      );

      workoutsBox.add(newWorkout);

      emit(state.copyWith(workouts: workoutsBox.values.toList()));
    });

  }
}
