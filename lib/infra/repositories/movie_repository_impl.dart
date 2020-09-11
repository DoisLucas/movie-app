import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/infra/datasource/movie_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getMoviesUpcoming(int page) {
    return datasource.movieUpComing(page);
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieID) {
    return datasource.movieDetails(movieID);
  }

  @override
  Future<List<Movie>> getMoviesByTitle(String title, int page) {
    return datasource.movieByTitle(title, page);
  }
}
