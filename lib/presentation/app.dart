import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholefit/logic/workout/workout_event.dart';
import 'package:wholefit/presentation/screens/homescreen.dart';

import '../logic/workout/workout_bloc.dart';


class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // All blocs will be added here
        BlocProvider(create: (_) => WorkoutBloc()..add(LoadWorkouts())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
