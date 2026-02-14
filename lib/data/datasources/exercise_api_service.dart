import 'package:dio/dio.dart';
import '../models/exercise_model.dart';

class ExerciseApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://exercisedb.vercel.app/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<Exercise>> fetchExercisesByBodyPart(String bodyPart) async {
    try {
      final response = await _dio.get('/exercises/bodyPart/$bodyPart');

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => Exercise.fromJson(e)).toList();
      } else {
        throw Exception("Failed to fetch exercises for $bodyPart");
      }
    } catch (e) {
      print("API ERROR [$bodyPart]: $e");
      rethrow;
    }
  }
}
