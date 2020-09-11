import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';

class MovieDetails {
  final MovieRepository repository;

  MovieDetails(this.repository);

  Future<MovieDetail> call(int movieId) async {
    MovieDetail result = await repository.getMovieDetail(movieId);
    return result;
  }
}
