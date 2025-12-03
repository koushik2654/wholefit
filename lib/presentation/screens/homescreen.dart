import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/workout/workout_bloc.dart';
import '../../../logic/workout/workout_event.dart';
import '../../../logic/workout/workout_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title:const Text("Home",style: TextStyle(color: Colors.black,fontSize: 23),
      ),),
      body: Container(color: Colors.white70,
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
                  title: Text(workout["name"]),
                  subtitle: Text("Reps: ${workout['reps']}"),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddWorkoutDialog(context);
        },
      ),
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final repsCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Workout"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Workout Name"),
              ),
              TextField(
                controller: repsCtrl,
                decoration: const InputDecoration(labelText: "Reps"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                context.read<WorkoutBloc>().add(
                  AddWorkout(
                    nameCtrl.text,
                    int.tryParse(repsCtrl.text) ?? 0,
                  ),
                );
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
