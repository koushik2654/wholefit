import 'package:flutter_bloc/flutter_bloc.dart';
import 'workout_event.dart';
import 'workout_state.dart';
import 'package:hive/hive.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final workoutsBox=Hive.box('workoutsBox');
  WorkoutBloc() : super(const WorkoutState()) {

    on<LoadWorkouts>((event, emit) {
      final stored = workoutsBox.get('workouts', defaultValue: []);
      final storedworkouts = (stored as List).map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();
      emit(state.copyWith(workouts:  List<Map<String,dynamic>>.from(storedworkouts)));
    });

    on<AddWorkout>((event, emit) {
      final updatedList = List<Map<String, dynamic>>.from(state.workouts);
      updatedList.add({"name": event.name, "reps": event.reps,
      });
      workoutsBox.put('workouts', updatedList);
      emit(state.copyWith(workouts: updatedList));
    });
  }
}
