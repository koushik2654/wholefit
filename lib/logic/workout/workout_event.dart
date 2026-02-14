import 'package:equatable/equatable.dart';

import '../../data/models/exercise_model.dart';

abstract class WorkoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWorkouts extends WorkoutEvent {}

// When user adds workout
class AddWorkout extends WorkoutEvent {
  final Exercise exercise;
  final int reps;

  AddWorkout(this.exercise, this.reps);

  @override
  List<Object?> get props => [exercise, reps];
}

