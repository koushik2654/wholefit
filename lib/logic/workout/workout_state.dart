import 'package:equatable/equatable.dart';
import '../../data/models/workout_model.dart';

class WorkoutState extends Equatable {
  final List<Workout> workouts;

  const WorkoutState({
    this.workouts = const [],
  });

  WorkoutState copyWith({
    List<Workout>? workouts,
  }) {
    return WorkoutState(
      workouts: workouts ?? this.workouts,
    );
  }

  @override
  List<Object?> get props => [workouts];
}
