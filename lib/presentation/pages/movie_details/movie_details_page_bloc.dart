import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/domain/usecases/movie_details.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsPageBloc {
  final MovieDetails _moviesDetails;
  final movieDetails = BehaviorSubject<MovieDetail>();

  MovieDetailsPageBloc(this._moviesDetails);

  Future<void> getMovieDetails(int movieId) async {
    movieDetails.add(await _moviesDetails(movieId));
  }

  void dispose() {
    movieDetails.close();
  }
}
