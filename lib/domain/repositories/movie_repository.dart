import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/entities/movie_details.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMoviesUpcoming(int page);
  Future<MovieDetail> getMovieDetail(int movieID);
  Future<List<Movie>> getMoviesByTitle(String title, int page);
}
