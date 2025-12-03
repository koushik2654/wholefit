import 'package:equatable/equatable.dart';

abstract class WorkoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWorkouts extends WorkoutEvent {}

// When user adds workout
class AddWorkout extends WorkoutEvent {
  final String name;
  final int reps;

  AddWorkout(this.name, this.reps);

  @override
  List<Object?> get props => [name, reps];
}
