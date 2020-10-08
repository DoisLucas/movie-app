import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/entities/movie_details.dart';

abstract class MovieDatasource {
  Future<List<Movie>> movieUpComing(int page);
  Future<MovieDetail> movieDetails(int movieId);
  Future<List<Movie>> movieByTitle(String title, int page);
}
