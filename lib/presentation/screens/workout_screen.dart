import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/workout/workout_bloc.dart';
import '../../../logic/workout/workout_event.dart';
import 'package:hive/hive.dart';
import '../../../data/models/exercise_model.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<WorkoutScreen> {
  final TextEditingController repsCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final List<Exercise> allExercises;
  Exercise? selectedExercise;

  @override
  void initState() {
    super.initState();
    // Make sure the box is already opened in main.dart
    allExercises = Hive.box<Exercise>('exerciseBox').values.toList();
  }

  @override
  void dispose() {
    repsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Workout"),
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected exercise',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: selectedExercise != null && selectedExercise!.gifUrl.isNotEmpty
                            ? Image.network(
                          selectedExercise!.gifUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image_not_supported, size: 20),
                          ),
                        )
                            : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.fitness_center),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          selectedExercise?.name ?? 'No exercise selected',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Reps input
                TextFormField(
                  controller: repsCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Reps",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter reps";
                    }
                    if (int.tryParse(value) == null) {
                      return "Reps must be a number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Exercise dropdown with safe layout
                const Text("Choose exercise"),
                 SizedBox(height: 50),
                DropdownButtonFormField<Exercise>(
                  value: selectedExercise,
                  decoration: InputDecoration(
                    labelText: "Select Exercise",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: allExercises.map((exercise) {
                    return DropdownMenuItem<Exercise>(
                      value: exercise,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: exercise.gifUrl.isNotEmpty
                                ? Image.network(
                              exercise.gifUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 40,
                                height: 40,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image_not_supported, size: 18),
                              ),
                            )
                                : Container(
                              width: 40,
                              height: 40,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.fitness_center, size: 18),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                exercise.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${exercise.bodyPart} • ${exercise.equipment}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedExercise = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return "Select an exercise";
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // dispatch event with selected exercise and reps
                        context.read<WorkoutBloc>().add(
                          AddWorkout(
                            selectedExercise!,
                            int.parse(repsCtrl.text),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text("Save Workout"),
                    ),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
    );
  }
}
