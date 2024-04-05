import 'package:bloc/bloc.dart';
import 'package:practica2mobile/repository/movies_repository.dart'; // Importa tu servicio de películas

// Estados relacionados con las películas populares
abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<dynamic> movies;

  PopularMoviesLoaded(this.movies);
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  PopularMoviesError(this.message);
}

// Eventos relacionados con las películas populares
abstract class PopularMoviesEvent {}

class FetchPopularMovies extends PopularMoviesEvent {}

// Cubit para manejar el estado de las películas populares
class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final MovieService _movieService = MovieService();

  PopularMoviesCubit() : super(PopularMoviesInitial());

  Future<void> fetchPopularMovies() async {
    try {
      emit(PopularMoviesLoading());
      final movies = await _movieService.getPopularMovies();
      emit(PopularMoviesLoaded(movies));
    } catch (error) {
      emit(PopularMoviesError('Failed to fetch popular movies'));
    }
  }
}
