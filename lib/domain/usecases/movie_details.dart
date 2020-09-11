import 'package:moviap/domain/entities/movie.dart';
import 'package:moviap/domain/entities/movie_details.dart';
import 'package:moviap/domain/repositories/movie_repository.dart';

class MovieDetails {
  final MovieRepository repository;

  MovieDetails(this.repository);

  Future<MovieDetail> call(int movieId) async {
    MovieDetail result = await repository.getMovieDetail(movieId);
    return result;
  }
}
