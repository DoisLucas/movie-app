import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/usecases/movie_upcoming.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final MoviesUpcoming _moviesUpcoming;
  final listMovies = BehaviorSubject<List<Movie>>();

  bool _isFetching = false;
  int _pageIndicator = 1;

  HomeBloc(this._moviesUpcoming);

  Future<void> getMoviesUpcoming({int page = 1}) async {
    _isFetching = true;
    if (listMovies.value == null) {
      List<Movie> movies = await _moviesUpcoming(page);
      listMovies.add(<Movie>[] + movies);
    } else {
      List<Movie> movies = await _moviesUpcoming(page);
      listMovies.add(listMovies.value + movies);
    }

    Future.delayed(Duration(seconds: 1), () {
      _isFetching = false;
    });
  }

  void nextPage() async {
    if (!_isFetching) {
      _pageIndicator++;
      await getMoviesUpcoming(page: _pageIndicator);
      print("Total ${listMovies.value.length}");
    }
  }

  void dispose() {
    listMovies.close();
  }
}
