import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';

class MoviesUpcoming {
  final MovieRepository repository;

  MoviesUpcoming(this.repository);

  Future<List<Movie>> call(int page) async {
    List<Movie> result = await repository.getMoviesUpcoming(page);
    return result;
  }
}
