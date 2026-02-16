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
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          children: const [
            Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
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
    );
  }
}
