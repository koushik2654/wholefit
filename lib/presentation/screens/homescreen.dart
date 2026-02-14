import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholefit/presentation/screens/workout_screen.dart';
import '../../../logic/workout/workout_bloc.dart';
import '../../../logic/workout/workout_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black, fontSize: 23),
        ),
      ),
      body: Container(
        color: Colors.white70,
        child: BlocBuilder<WorkoutBloc, WorkoutState>(
          builder: (context, state) {
            if (state.workouts.isEmpty) {
              return const Center(
                child: Text("No workouts added yet."),
              );
            }

            return ListView.builder(
              itemCount: state.workouts.length,
              itemBuilder: (context, index) {
                final workout = state.workouts[index];

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: workout.gifUrl.isNotEmpty
                        ? Image.network(
                      workout.gifUrl,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 55,
                      height: 55,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.fitness_center),
                    ),
                  ),
                  title: Text(workout.name),
                  subtitle: Text(
                    "${workout.bodyPart} • ${workout.reps} reps • ${workout.equipment}",
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WorkoutScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
