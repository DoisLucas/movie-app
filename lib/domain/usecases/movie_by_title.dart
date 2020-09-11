import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';

class MovieByTitle {
  final MovieRepository repository;

  MovieByTitle(this.repository);

  Future<List<Movie>> call(String title, int page) async {
    List<Movie> result = await repository.getMoviesByTitle(title, page);
    return result;
  }
}
