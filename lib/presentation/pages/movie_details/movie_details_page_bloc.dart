import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/domain/usecases/movie_details.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsPageBloc {
  final MovieDetails _moviesDetails;
  final _movieDetails = BehaviorSubject<MovieDetail>();

  MovieDetailsPageBloc(this._moviesDetails);

  get movieDetails => _movieDetails;

  Future<void> getMovieDetails(int movieId) async {
    _movieDetails.add(await _moviesDetails(movieId));
  }

  void dispose() {
    _movieDetails.close();
  }
}
