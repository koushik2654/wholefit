import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/exercise_model.dart';

class ExerciseLocalService {
  Future<List<Exercise>> loadLocalExercises() async {
    final jsonString = await rootBundle.loadString('assets/data/exercises.json');

    final List data = json.decode(jsonString);

    return data.map((e) => Exercise.fromJson(e)).toList();
  }
}
