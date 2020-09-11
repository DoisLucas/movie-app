import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/usecases/movie_upcoming.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final MoviesUpcoming _moviesUpcoming;

  final _listMovies = BehaviorSubject<List<Movie>>.seeded([]);
  int _pageIndicator = 1;
  bool isFetching = false;

  HomeBloc(this._moviesUpcoming);

  get listMovies => _listMovies;

  Future<void> getMoviesUpcoming({int page = 1}) async {
    isFetching = true;
    listMovies.add(listMovies.value + await _moviesUpcoming(page));
    isFetching = false;
  }

  void nextPage() async {
    if (!isFetching) {
      _pageIndicator++;
      await getMoviesUpcoming(page: _pageIndicator);
      print("Total ${listMovies.value.length}");
    }
  }

  void dispose() {
    _listMovies.close();
  }
}
