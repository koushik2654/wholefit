import 'package:equatable/equatable.dart';

class WorkoutState extends Equatable {
  final List<Map<String, dynamic>> workouts;

  const WorkoutState({
    this.workouts = const [],
  });

  WorkoutState copyWith({
    List<Map<String, dynamic>>? workouts,
  }) {
    return WorkoutState(
      workouts: workouts ?? this.workouts,
    );
  }

  @override
  List<Object?> get props => [workouts];
}
