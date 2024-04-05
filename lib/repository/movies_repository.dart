import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio = Dio();

  final String _apiKey = '0822a17859a3e05052902238b018e409'; // Reemplaza 'TU_API_KEY' con tu propia API key

  Future<List<dynamic>> getPopularMovies() async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }
}
